import 'package:hive_flutter/adapters.dart';
import 'package:sloking/enums/game_card_state.dart';

import '../enums/game_card_type.dart';

part 'game_card.g.dart';

@HiveType(typeId: 2)
class GameCard {
  const GameCard({
    required this.type,
    this.state = GameCardState.closed,
  });

  GameCard.lemon({GameCardState state = GameCardState.closed})
      : this(
          type: GameCardType.lemon,
          state: state,
        );

  GameCard.watermelon({GameCardState state = GameCardState.closed})
      : this(
          type: GameCardType.watermelon,
          state: state,
        );

  GameCard.plum({GameCardState state = GameCardState.closed})
      : this(
          type: GameCardType.plum,
          state: state,
        );

  GameCard.strawberry({GameCardState state = GameCardState.closed})
      : this(
          type: GameCardType.strawberry,
          state: state,
        );

  GameCard.cherry({GameCardState state = GameCardState.closed})
      : this(
          type: GameCardType.cherry,
          state: state,
        );

  GameCard flip() {
    return GameCard(
      type: type,
      state: state == GameCardState.closed ? GameCardState.open : GameCardState.closed,
    );
  }

  GameCard changeState(GameCardState newState) {
    return GameCard(
      type: type,
      state: newState,
    );
  }

  @HiveField(0)
  final GameCardType type;

  @HiveField(1)
  final GameCardState state;
}
