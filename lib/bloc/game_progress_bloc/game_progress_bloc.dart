import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

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
    on<AddGemsGameProgressEvent>(_addGems);
    on<FortuneWheelSpinProgressEvent>(_fortuneWheelSpin);


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
    print("LOADED FROM HIVE:\n gemCount: $gemCount\n nextWheelSpin: $nextWheelSpin");

    emit(LoadedGameProgressState(gemCount: gemCount ?? state.gemCount, liveCount: state.liveCount, nextWheelSpin: nextWheelSpin ?? state.nextWheelSpin));
  }
  
  Future<void> _addGems(AddGemsGameProgressEvent event, Emitter<GameProgressState> emit) async {
    final int gemCount = state.gemCount + event.gems;
    emit(LoadedGameProgressState(gemCount: gemCount, liveCount: state.liveCount, nextWheelSpin: state.nextWheelSpin));
  }

  Future<void> _fortuneWheelSpin(FortuneWheelSpinProgressEvent event, Emitter<GameProgressState> emit) async {
    final int gemCount = state.gemCount + event.gemsAdd;
    final DateTime nextWheelSpin = DateTime.now().add(event.delay);
    _hiveRepository.saveContent("gemCount", gemCount);
    _hiveRepository.saveContent("nextWheelSpin", nextWheelSpin);
    emit(LoadedGameProgressState(gemCount: gemCount, liveCount: state.liveCount, nextWheelSpin: nextWheelSpin));
  }
}
