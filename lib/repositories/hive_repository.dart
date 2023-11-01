import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

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
    //TODO: Сделать адаптер игрового процесса
  }

  Future<void> saveContent(String key, dynamic value) async {
    try {
      await box.put(key, value);
      final map = box.toMap();
      print("saved: {$key : ${map[key]}}");
    } catch (error) {
      print("save error");
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
