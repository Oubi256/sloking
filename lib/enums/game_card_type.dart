import 'package:hive_flutter/adapters.dart';

part 'game_card_type.g.dart';

@HiveType(typeId: 3)
enum GameCardType {
  @HiveField(0)
  lemon(iconAssetName: "assets/images/card/icons/slots_01.png"),
  @HiveField(1)
  watermelon(iconAssetName: "assets/images/card/icons/slots_02.png"),
  @HiveField(2)
  plum(iconAssetName: "assets/images/card/icons/slots_03.png"),
  @HiveField(3)
  strawberry(iconAssetName: "assets/images/card/icons/slots_04.png"),
  @HiveField(4)
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