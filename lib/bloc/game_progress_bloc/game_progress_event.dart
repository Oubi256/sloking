part of 'game_progress_bloc.dart';

@immutable
abstract class GameProgressEvent {
  const GameProgressEvent();
}

class StartGameInitProgressEvent extends GameProgressEvent {
  const StartGameInitProgressEvent();
}

class AddGemsGameProgressEvent extends GameProgressEvent {
  final int gems;

  const AddGemsGameProgressEvent(this.gems);
}

class FortuneWheelSpinProgressEvent extends GameProgressEvent {
  final int gemsAdd;
  final Duration delay;

  const FortuneWheelSpinProgressEvent({this.gemsAdd = 0, this.delay = const Duration(days: 1)});
}

class HitOnHeartProgressEvent extends GameProgressEvent {
  final int heartHitForce;

  const HitOnHeartProgressEvent({this.heartHitForce = 1});
}


class StartGameProgressEvent extends GameProgressEvent {
  final int cardOnField;
  final int combinationReward;

  const StartGameProgressEvent({required this.cardOnField, required this.combinationReward});
}