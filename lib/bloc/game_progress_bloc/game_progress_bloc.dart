import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:meta/meta.dart';
import 'package:sloking/enums/game_card_state.dart';
import 'package:sloking/extensions/game_field_extension.dart';
import 'package:sloking/game_levels.dart';
import 'package:sloking/models/game_level_progress.dart';

import '../../models/game_level.dart';
import '../../repositories/hive_repository.dart';

part 'game_progress_event.dart';
part 'game_progress_state.dart';

class GameProgressBloc extends Bloc<GameProgressEvent, GameProgressState> {
  late final HiveRepository _hiveRepository;

  final ValueNotifier<bool> isInitialized = ValueNotifier(false);

  GameProgressBloc({required HiveRepository hiveRepository}) : super(GameProgressInitial()) {
    _hiveRepository = hiveRepository;
    isInitialized.addListener(onInitFinished);
    _hiveRepository.isInitialized.addListener(hiveInitListener);

    on<StartGameInitProgressEvent>(_startInit);
    on<FortuneWheelSpinProgressEvent>(_fortuneWheelSpin);
    on<NewGameProgressEvent>(_newGame);
    on<ContinueGameProgressEvent>(_continueGame);
    on<ChangeCardStateProgressEvent>(_changeCardState);
    on<HealthHitProgressEvent>(_healthHit);
    on<AddGemsProgressEvent>(_addGems);

  }

  void hiveInitListener() {
    if (_hiveRepository.isInitialized.value) {
      isInitialized.value = true;
    } else {
      _hiveRepository.isInitialized.removeListener(hiveInitListener);
    }
  }

  void onInitFinished() {
    add(const StartGameInitProgressEvent());
  }

  Future<void> _startInit(StartGameInitProgressEvent event, Emitter<GameProgressState> emit) async {
    final int? gemCount = await _hiveRepository.getContent("gemCount");
    final DateTime? nextWheelSpin = await _hiveRepository.getContent("nextWheelSpin");
    final GameLevelProgress? gameLevelProgress = await _hiveRepository.getContent("gameLevelProgress");

    print("LOADED FROM HIVE:\n gemCount: $gemCount\n nextWheelSpin: $nextWheelSpin\n gameLevelProgress: $gameLevelProgress");

    emit(LoadedGameProgressState(gemCount: gemCount ?? state.gemCount, nextWheelSpin: nextWheelSpin ?? state.nextWheelSpin, gameLevelProgress: gameLevelProgress ?? state.gameLevelProgress));
  }

  Future<void> _fortuneWheelSpin(FortuneWheelSpinProgressEvent event, Emitter<GameProgressState> emit) async {
    final int gemCount = state.gemCount + event.gemsAdd;
    final DateTime nextWheelSpin = DateTime.now().add(event.delay);
    _hiveRepository.saveContent("gemCount", gemCount);
    _hiveRepository.saveContent("nextWheelSpin", nextWheelSpin);
    emit(LoadedGameProgressState(gemCount: gemCount, nextWheelSpin: nextWheelSpin, gameLevelProgress: state.gameLevelProgress));
  }

  Future<void> _newGame(NewGameProgressEvent event, Emitter<GameProgressState> emit) async {
    GameLevel? newLevel;
    if (event.nextLevel) {
      newLevel = gameLevels[min(state.gameLevelProgress.gameLevel.id + 1, gameLevels.length-1)];
      print("SELECTED LEVEL: ${newLevel.id}");
    }

    if (event.tryAgain) {
      newLevel = state.gameLevelProgress.gameLevel;
    }
    newLevel = newLevel ?? gameLevels.first;

    final GameLevelProgress gameLevelProgress = GameLevelProgress.startGame(gameLevel: newLevel);
    _hiveRepository.saveContent("gameLevelProgress", gameLevelProgress);

    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: gameLevelProgress,
    ));
  }

  Future<void> _continueGame(ContinueGameProgressEvent event, Emitter<GameProgressState> emit) async {
    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: state.gameLevelProgress,
    ));
  }

  Future<void> _changeCardState(ChangeCardStateProgressEvent event, Emitter<GameProgressState> emit) async {
    GameLevelProgress updatedProgress = state.gameLevelProgress.copyWith(
      gameField: state.gameLevelProgress.gameField.changeCardState(event.cardIndex, event.newCardState),
    );

    _hiveRepository.saveContent("gameLevelProgress", updatedProgress);

    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: updatedProgress,
    ));
  }

  Future<void> _healthHit(HealthHitProgressEvent event, Emitter<GameProgressState> emit) async {
    GameLevelProgress updatedProgress = state.gameLevelProgress.copyWith(
      healthCount: state.gameLevelProgress.healthCount - 1,
    );

    _hiveRepository.saveContent("gameLevelProgress", updatedProgress);

    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: updatedProgress,
    ));
  }

  Future<void> _addGems(AddGemsProgressEvent event, Emitter<GameProgressState> emit) async {
    final int gemCount = state.gemCount + state.gameLevelProgress.gameLevel.combinationReward;
    _hiveRepository.saveContent("gemCount", gemCount);

    emit(LoadedGameProgressState(
      gemCount: gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: state.gameLevelProgress,
    ));
  }
}
