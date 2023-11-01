import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sloking/game_levels.dart';
import 'package:sloking/models/game_level_progress.dart';

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
    on<FlipCardProgressEvent>(_flipCard);
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
    emit(LoadedGameProgressState(
      gemCount: state.gemCount,
      nextWheelSpin: state.nextWheelSpin,
      gameLevelProgress: state.gameLevelProgress,
    ));
  }

  Future<void> _flipCard(FlipCardProgressEvent event, Emitter<GameProgressState> emit) async {
    emit(LoadedGameProgressState(gemCount: state.gemCount, nextWheelSpin: state.nextWheelSpin, gameLevelProgress: state.gameLevelProgress));
  }
}
