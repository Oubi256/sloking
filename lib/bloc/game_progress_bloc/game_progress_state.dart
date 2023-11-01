part of 'game_progress_bloc.dart';

@immutable
abstract class GameProgressState {
  final int gemCount;
  final DateTime nextWheelSpin;
  final GameLevelProgress? gameLevelProgress;

  const GameProgressState({required this.gemCount, required this.nextWheelSpin, this.gameLevelProgress});
}

class GameProgressInitial extends GameProgressState {
  GameProgressInitial() : super(gemCount: 0, nextWheelSpin: DateTime.now(), gameLevelProgress: null);
}

class LoadedGameProgressState extends GameProgressState {
  const LoadedGameProgressState({required super.gemCount, required super.nextWheelSpin, required super.gameLevelProgress});
}
