import '../models/game_level_progress.dart';

extension FieldActions on GameField {
  GameField flipCard(int index) {
    GameField updatedGameField = this;
    updatedGameField[index] = updatedGameField[index].flip();
    return updatedGameField;
  }
}