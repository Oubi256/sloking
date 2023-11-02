import 'package:sloking/models/game_card.dart';
import 'package:sloking/game_levels.dart';

import 'game_level.dart';

typedef GameField = List<GameCard>;

class GameLevelProgress {
  final GameLevel gameLevel;
  final GameField gameField;
  final int healthCount;

  const GameLevelProgress({required this.gameLevel, required this.gameField, required this.healthCount});

  GameLevelProgress.startGame({required this.gameLevel})
      : gameField = gameLevel.generateField(),
        healthCount = 3;

  GameLevelProgress.none()
      : gameLevel = gameLevels.first,
        gameField = [],
        healthCount = 0;

  GameLevelProgress copyWith({
    GameLevel? gameLevel,
    GameField? gameField,
    int? healthCount,
  }) {
    return GameLevelProgress(
      gameLevel: gameLevel ?? this.gameLevel,
      gameField: gameField ?? this.gameField,
      healthCount: healthCount ?? this.healthCount,
    );
  }
}
