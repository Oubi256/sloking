import 'package:hive_flutter/adapters.dart';
import 'package:sloking/models/game_card.dart';
import 'package:sloking/game_levels.dart';

import 'game_level.dart';


part 'game_level_progress.g.dart';

typedef GameField = List<GameCard>;

@HiveType(typeId: 1)
class GameLevelProgress extends HiveObject {
  @HiveField(0)
  final GameLevel gameLevel;

  @HiveField(1)
  final GameField gameField;

  @HiveField(2)
  final int healthCount;

  GameLevelProgress({required this.gameLevel, required this.gameField, required this.healthCount});

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
