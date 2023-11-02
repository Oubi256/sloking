// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_level_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameLevelProgressAdapter extends TypeAdapter<GameLevelProgress> {
  @override
  final int typeId = 1;

  @override
  GameLevelProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameLevelProgress(
      gameLevel: fields[0] as GameLevel,
      gameField: (fields[1] as List).cast<GameCard>(),
      healthCount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameLevelProgress obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.gameLevel)
      ..writeByte(1)
      ..write(obj.gameField)
      ..writeByte(2)
      ..write(obj.healthCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameLevelProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
