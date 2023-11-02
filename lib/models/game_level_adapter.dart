import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sloking/game_levels.dart';

import 'game_level.dart';

class GameLevelAdapter extends TypeAdapter<GameLevel> {
  @override
  final int typeId = 100;

  @override
  GameLevel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameLevel(
      id: fields[0] as int,
      row: fields[2] as int,
      column: fields[3] as int,
      backgroundImage: gameLevels[fields[1] as int].backgroundImage,
      combinationReward: fields[4] as int,
      minUniqueCards: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameLevel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.row)
      ..writeByte(3)
      ..write(obj.column)
      ..writeByte(4)
      ..write(obj.combinationReward)
      ..writeByte(5)
      ..write(obj.minUniqueCards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GameLevelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}