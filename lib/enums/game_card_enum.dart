import 'package:sloking/enums/game_card_state_enum.dart';

enum GameCard {
  lemon(iconAssetName: "assets/images/card/icons/slots_01.png"),
  watermelon(iconAssetName: "assets/images/card/icons/slots_02.png"),
  plum(iconAssetName: "assets/images/card/icons/slots_03.png"),
  strawberry(iconAssetName: "assets/images/card/icons/slots_04.png"),
  cherry(iconAssetName: "assets/images/card/icons/slots_05.png");

  const GameCard({
    this.state = GameCardState.closed,
    required this.iconAssetName,
    this.backAssetName = "assets/images/card/backgrounds/card_back.png",
    this.faceAssetName = "assets/images/card/backgrounds/card_face.png"
  });

  final String iconAssetName;
  final String backAssetName;
  final String faceAssetName;
  final GameCardState state;
}
