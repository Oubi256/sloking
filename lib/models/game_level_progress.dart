import 'package:sloking/enums/game_card_enum.dart';

import 'game_level.dart';

typedef GameField = List<GameCard>;

class GameLevelProgress {
  final GameLevel gameLevel;
  final GameField gameField;
  final int healthCount;

  const GameLevelProgress._({required this.gameLevel, required this.gameField, required this.healthCount});

  GameLevelProgress.startGame({required this.gameLevel})
      : gameField = gameLevel.generateField(),
        healthCount = 3;
}
