// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(value) => "+${value} алмазов";

  static String m1(time) => "Следующий раз в ${time}";

  static String m2(value) => "Вы выиграли +${value} алмазов";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addGemsHint": m0,
        "backToMenu": MessageLookupByLibrary.simpleMessage("Меню"),
        "dailyBonus": MessageLookupByLibrary.simpleMessage("Ежедневный бонус"),
        "dialogButtonNextLevel":
            MessageLookupByLibrary.simpleMessage("Следующий уровень"),
        "dialogButtonTryAgain":
            MessageLookupByLibrary.simpleMessage("Попробовать еще"),
        "dialogDefeatHeader":
            MessageLookupByLibrary.simpleMessage("ИГРА ОКОНЧЕНА!"),
        "dialogWinHeader": MessageLookupByLibrary.simpleMessage("ПОБЕДА!"),
        "fortuneWheelDefeat":
            MessageLookupByLibrary.simpleMessage("Повезет в другой раз"),
        "fortuneWheelDelay": m1,
        "fortuneWheelSpin": MessageLookupByLibrary.simpleMessage("Вращать"),
        "fortuneWheelTryAgain":
            MessageLookupByLibrary.simpleMessage("Попробуй еще"),
        "fortuneWheelWin": MessageLookupByLibrary.simpleMessage("Поздравляем!"),
        "fortuneWheelWinReward": m2,
        "menuContinue": MessageLookupByLibrary.simpleMessage("Продолжить игру"),
        "menuNewGame": MessageLookupByLibrary.simpleMessage("Новая игра"),
        "menuRules": MessageLookupByLibrary.simpleMessage("Правила"),
        "rulesCards": MessageLookupByLibrary.simpleMessage(
            "Вам нужно собирать несколько элементов, которые спрятаны под карточками."),
        "rulesGems": MessageLookupByLibrary.simpleMessage(
            "За каждую собранную пару вы получаете алмазы."),
        "rulesHealth": MessageLookupByLibrary.simpleMessage(
            "Если попытка будет неудачной, вы будете терять одно сердце. Когда у вас закончатся сердца, игра будет закончена.")
      };
}
