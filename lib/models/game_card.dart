import 'package:sloking/enums/game_card_state_enum.dart';

enum GameCardType {
  lemon(iconAssetName: "assets/images/card/icons/slots_01.png"),
  watermelon(iconAssetName: "assets/images/card/icons/slots_02.png"),
  plum(iconAssetName: "assets/images/card/icons/slots_03.png"),
  strawberry(iconAssetName: "assets/images/card/icons/slots_04.png"),
  cherry(iconAssetName: "assets/images/card/icons/slots_05.png");

  const GameCardType({
    required this.iconAssetName,
    this.backAssetName = "assets/images/card/backgrounds/card_back.png",
    this.faceAssetName = "assets/images/card/backgrounds/card_face.png",
  });

  final String iconAssetName;
  final String backAssetName;
  final String faceAssetName;
}

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

  final GameCardType type;
  final GameCardState state;
}
