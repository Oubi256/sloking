// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCardAdapter extends TypeAdapter<GameCard> {
  @override
  final int typeId = 2;

  @override
  GameCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameCard(
      type: fields[0] as GameCardType,
      state: fields[1] as GameCardState,
    );
  }

  @override
  void write(BinaryWriter writer, GameCard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
