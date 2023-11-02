import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sloking/models/game_card.dart';

import '../enums/game_card_type.dart';
import 'game_level_progress.dart';

//part 'game_level.g.dart';


class GameLevel extends HiveObject {
  final int id;

  final Image? backgroundImage;

  final int row;

  final int column;

  final int combinationReward;

  final int minUniqueCards;

   GameLevel({
    required this.id,
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
    while (uniqueSelectedCards.length < min(halfCount, min(minUniqueCards, GameCardType.values.length))) {
      GameCard randomUniqueCard = GameCard(type: GameCardType.values[random.nextInt(GameCardType.values.length)]);
      uniqueSelectedCards.add(randomUniqueCard);
    }

    List<GameCard> gameField = uniqueSelectedCards.toList();
    while (gameField.length < halfCount) {
      GameCard randomCard = GameCard(type: GameCardType.values[random.nextInt(GameCardType.values.length)]);
      gameField.add(randomCard);
    }
    return [...gameField, ...gameField]..shuffle();
  }
}
