
import 'package:hive_flutter/adapters.dart';

part 'game_card_state.g.dart';

@HiveType(typeId: 4)
enum GameCardState {
  @HiveField(0)
  open,
  @HiveField(1)
  closed,
  @HiveField(2)
  hidden,
}
