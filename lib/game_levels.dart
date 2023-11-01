import 'package:flutter/material.dart';
import 'package:sloking/models/game_level.dart';

final List<GameLevel> gameLevels = [
  GameLevel(
    row: 2,
    column: 3,
    backgroundImage: Image.asset(
      "assets/images/backgrounds/background_01.png",
      fit: BoxFit.cover,
      alignment: const Alignment(-0.4, 0),
    ),
    combinationReward: 10,
    minUniqueCards: 3,
  ),
  GameLevel(
    row: 2,
    column: 4,
    backgroundImage: Image.asset(
      "assets/images/backgrounds/background_02.png",
      fit: BoxFit.cover,
      alignment: const Alignment(-0.1, 0),
    ),
    combinationReward: 12,
    minUniqueCards: 4,
  ),
];
