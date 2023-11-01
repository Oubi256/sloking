import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sloking/enums/game_card_enum.dart';

import 'game_level_progress.dart';

class GameLevel {
  final Image backgroundImage;
  final int row;
  final int column;
  final int combinationReward;
  final int minUniqueCards;

  const GameLevel({
    required this.row,
    required this.column,
    required this.backgroundImage,
    required this.combinationReward,
    required this.minUniqueCards,
  });

  int get itemsCount => row * column;

  GameField generateField() {
    final Random random = Random();
    final int halfCount = itemsCount ~/ 2;
    Set<GameCard> uniqueSelectedCards = {};
    while (uniqueSelectedCards.length < min(halfCount, min(minUniqueCards, GameCard.values.length))) {
      GameCard randomUniqueCard = GameCard.values[random.nextInt(GameCard.values.length)];
      uniqueSelectedCards.add(randomUniqueCard);
    }

    List<GameCard> gameField = uniqueSelectedCards.toList();
    while (gameField.length < halfCount) {
      GameCard randomCard = GameCard.values[random.nextInt(GameCard.values.length)];
      gameField.add(randomCard);
    }
    return [...gameField, ...gameField]..shuffle();
  }
}
