import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sloking/enums/game_card_state.dart';
import 'package:sloking/enums/game_card_type.dart';
import 'package:sloking/models/game_card.dart';
import 'package:sloking/models/game_level_adapter.dart';
import 'package:sloking/models/game_level_progress.dart';

class HiveRepository {
  HiveRepository._();

  ValueNotifier<bool> isInitialized = ValueNotifier(false);

  HiveRepository.init() {
    _init();
  }

  late final Box<dynamic> box;

  Future<void> _init() async {
    await Hive.initFlutter();
    _registerAdapters();
    box = await Hive.openBox('sloking');
    isInitialized.value = true;
  }

  void _registerAdapters() {
    Hive.registerAdapter(GameLevelProgressAdapter());
    Hive.registerAdapter(GameLevelAdapter());
    Hive.registerAdapter(GameCardAdapter());
    Hive.registerAdapter(GameCardStateAdapter());
    Hive.registerAdapter(GameCardTypeAdapter());




    //Hive.registerAdapter(GameLevelAdapter());
  }

  Future<void> saveContent(String key, dynamic value) async {
    try {
      await box.put(key, value);
      final map = box.toMap();
      print("saved: {$key : ${map[key]}}");
    } catch (error) {
      print("save error: $error");
    }
  }

  Future<dynamic> getContent(String key) async {
    try {
      await box.get(key);
      final map = box.toMap();
      return map[key];
    } catch (error) {
      print("loaded error: $error");
    }
  }
}
