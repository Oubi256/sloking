import 'package:sloking/enums/game_card_state.dart';

import '../models/game_level_progress.dart';

extension FieldActions on GameField {
  GameField changeCardState(int index, GameCardState newState) {
    GameField updatedGameField = this;
    updatedGameField[index] = updatedGameField[index].changeState(newState);
    return updatedGameField;
  }

  List<int> indexByState(GameCardState state) {

    List<int> result = List.empty(growable: true);

    for (int i = 0; i < length; i++) {
      if (this[i].state == state) {
        result.add(i);
      }
    }

    return result;
  }

}