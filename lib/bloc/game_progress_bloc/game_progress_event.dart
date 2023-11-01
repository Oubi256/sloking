part of 'game_progress_bloc.dart';

@immutable
abstract class GameProgressEvent {
  const GameProgressEvent();
}

class StartGameInitProgressEvent extends GameProgressEvent {
  const StartGameInitProgressEvent();
}

class FortuneWheelSpinProgressEvent extends GameProgressEvent {
  final int gemsAdd;
  final Duration delay;

  const FortuneWheelSpinProgressEvent({this.gemsAdd = 0, this.delay = const Duration(days: 1)});
}

class NewGameProgressEvent extends GameProgressEvent {
  const NewGameProgressEvent();
}

class ContinueGameProgressEvent extends GameProgressEvent {
  const ContinueGameProgressEvent();
}

class FlipCardProgressEvent extends GameProgressEvent {
  const FlipCardProgressEvent();
}