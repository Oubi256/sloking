// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCardStateAdapter extends TypeAdapter<GameCardState> {
  @override
  final int typeId = 4;

  @override
  GameCardState read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameCardState.open;
      case 1:
        return GameCardState.closed;
      case 2:
        return GameCardState.hidden;
      default:
        return GameCardState.open;
    }
  }

  @override
  void write(BinaryWriter writer, GameCardState obj) {
    switch (obj) {
      case GameCardState.open:
        writer.writeByte(0);
        break;
      case GameCardState.closed:
        writer.writeByte(1);
        break;
      case GameCardState.hidden:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCardStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
