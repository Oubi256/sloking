import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:meta/meta.dart';
import 'package:sloking/enums/game_card_state_enum.dart';
import 'package:sloking/extensions/game_field_extension.dart';
import 'package:sloking/game_levels.dart';
import 'package:sloking/models/game_level_progress.dart';

import '../../models/game_card.dart';
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
    //TODO: Need to load game progress
    print("LOADED FROM HIVE:\n gemCount: $gemCount\n nextWheelSpin: $nextWheelSpin");

    emit(LoadedGameProgressState(gemCount: gemCount ?? state.gemCount, nextWheelSpin: nextWheelSpin ?? state.nextWheelSpin, gameLevelProgress: state.gameLevelProgress));
  }

  Future<void> _fortuneWheelSpin(FortuneWheelSpinProgressEvent event, Emitter<GameProgressState> emit) async {
    final int gemCount = state.gemCount + event.gemsAdd;
    final DateTime nextWheelSpin = DateTime.now().add(event.delay);
    _hiveRepository.saveContent("gemCount", gemCount);
    _hiveRepository.saveContent("nextWheelSpin", nextWheelSpin);
    emit(LoadedGameProgressState(gemCount: gemCount, nextWheelSpin: nextWheelSpin, gameLevelProgress: state.gameLevelProgress));
  }

  Future<void> _newGame(NewGameProgressEvent event, Emitter<GameProgressState> emit) async {
    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: GameLevelProgress.startGame(gameLevel: gameLevels.first),
    ));
  }

  Future<void> _continueGame(ContinueGameProgressEvent event, Emitter<GameProgressState> emit) async {
    print("continue: ${state.gameLevelProgress.gameField.map((e) => e.state).toList()}");
    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: state.gameLevelProgress,
    ));
  }

  Future<void> _changeCardState(ChangeCardStateProgressEvent event, Emitter<GameProgressState> emit) async {
    GameCard flippedCard = state.gameLevelProgress.gameField[event.cardIndex];
    print("FLIP CARD: ${flippedCard.state} | ${flippedCard.type.name}");
    GameLevelProgress updatedProgress = state.gameLevelProgress.copyWith(
      gameField: state.gameLevelProgress.gameField.changeCardState(event.cardIndex, event.newCardState),
    );
    print("flip: ${updatedProgress.gameField.map((e) => e.state).toList()}");

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
