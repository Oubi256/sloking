// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCardTypeAdapter extends TypeAdapter<GameCardType> {
  @override
  final int typeId = 3;

  @override
  GameCardType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameCardType.lemon;
      case 1:
        return GameCardType.watermelon;
      case 2:
        return GameCardType.plum;
      case 3:
        return GameCardType.strawberry;
      case 4:
        return GameCardType.cherry;
      default:
        return GameCardType.lemon;
    }
  }

  @override
  void write(BinaryWriter writer, GameCardType obj) {
    switch (obj) {
      case GameCardType.lemon:
        writer.writeByte(0);
        break;
      case GameCardType.watermelon:
        writer.writeByte(1);
        break;
      case GameCardType.plum:
        writer.writeByte(2);
        break;
      case GameCardType.strawberry:
        writer.writeByte(3);
        break;
      case GameCardType.cherry:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCardTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
