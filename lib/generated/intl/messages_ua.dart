// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ua locale. All the
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
  String get localeName => 'ua';

  static String m0(value) => "+${value} алмазів";

  static String m1(time) => "Наступний раз о ${time}";

  static String m2(value) => "Ви виграли +${value} алмазів";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addGemsHint": m0,
        "backToMenu": MessageLookupByLibrary.simpleMessage("Меню"),
        "dailyBonus": MessageLookupByLibrary.simpleMessage("Щоденний бонус"),
        "dialogButtonNextLevel":
            MessageLookupByLibrary.simpleMessage("Наступний рівень"),
        "dialogButtonTryAgain":
            MessageLookupByLibrary.simpleMessage("Спробувати ще"),
        "dialogDefeatHeader":
            MessageLookupByLibrary.simpleMessage("ГРУ ЗАКІНЧЕНО!"),
        "dialogWinHeader": MessageLookupByLibrary.simpleMessage("ПЕРЕМОГА!"),
        "fortuneWheelDefeat":
            MessageLookupByLibrary.simpleMessage("Пощастить іншим разом"),
        "fortuneWheelDelay": m1,
        "fortuneWheelSpin": MessageLookupByLibrary.simpleMessage("Обертати"),
        "fortuneWheelTryAgain":
            MessageLookupByLibrary.simpleMessage("Спробуй ще"),
        "fortuneWheelWin": MessageLookupByLibrary.simpleMessage("Вітаємо!"),
        "fortuneWheelWinReward": m2,
        "menuContinue": MessageLookupByLibrary.simpleMessage("Продовжити гру"),
        "menuNewGame": MessageLookupByLibrary.simpleMessage("Нова гра"),
        "menuRules": MessageLookupByLibrary.simpleMessage("Правила"),
        "rulesCards": MessageLookupByLibrary.simpleMessage(
            "Вам потрібно збирати кілька елементів, які заховані під картками."),
        "rulesGems": MessageLookupByLibrary.simpleMessage(
            "За кожну зібрану пару ви отримуєте алмази."),
        "rulesHealth": MessageLookupByLibrary.simpleMessage(
            "Якщо спроба буде невдалою, ви втрачатимете одне серце. Коли у вас закінчаться серця, гра буде закінчена.")
      };
}
