part of 'game_progress_bloc.dart';

@immutable
abstract class GameProgressState {
  final int gemCount;
  final int liveCount;
  final DateTime nextWheelSpin;

  const GameProgressState({required this.gemCount, required this.liveCount, required this.nextWheelSpin});
}

class GameProgressInitial extends GameProgressState {
  GameProgressInitial() : super(gemCount: 0, liveCount: 0, nextWheelSpin: DateTime.now());
}

class LoadedGameProgressState extends GameProgressState {
  const LoadedGameProgressState({required super.gemCount, required super.liveCount, required super.nextWheelSpin});
}
