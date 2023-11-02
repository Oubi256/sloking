// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Daily bonus`
  String get dailyBonus {
    return Intl.message(
      'Daily bonus',
      name: 'dailyBonus',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get menuContinue {
    return Intl.message(
      'Continue',
      name: 'menuContinue',
      desc: '',
      args: [],
    );
  }

  /// `New game`
  String get menuNewGame {
    return Intl.message(
      'New game',
      name: 'menuNewGame',
      desc: '',
      args: [],
    );
  }

  /// `Rules`
  String get menuRules {
    return Intl.message(
      'Rules',
      name: 'menuRules',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get fortuneWheelTryAgain {
    return Intl.message(
      'Try again',
      name: 'fortuneWheelTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Spin`
  String get fortuneWheelSpin {
    return Intl.message(
      'Spin',
      name: 'fortuneWheelSpin',
      desc: '',
      args: [],
    );
  }

  /// `Next time at {time}`
  String fortuneWheelDelay(DateTime time) {
    final DateFormat timeDateFormat = DateFormat.jms(Intl.getCurrentLocale());
    final String timeString = timeDateFormat.format(time);

    return Intl.message(
      'Next time at $timeString',
      name: 'fortuneWheelDelay',
      desc: '',
      args: [timeString],
    );
  }

  /// `Congratulations!`
  String get fortuneWheelWin {
    return Intl.message(
      'Congratulations!',
      name: 'fortuneWheelWin',
      desc: '',
      args: [],
    );
  }

  /// `You have won +{value} diamonds`
  String fortuneWheelWinReward(Object value) {
    return Intl.message(
      'You have won +$value diamonds',
      name: 'fortuneWheelWinReward',
      desc: '',
      args: [value],
    );
  }

  /// `Better luck next time`
  String get fortuneWheelDefeat {
    return Intl.message(
      'Better luck next time',
      name: 'fortuneWheelDefeat',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get backToMenu {
    return Intl.message(
      'Menu',
      name: 'backToMenu',
      desc: '',
      args: [],
    );
  }

  /// `You need to collect several items that are hidden under the cards.`
  String get rulesCards {
    return Intl.message(
      'You need to collect several items that are hidden under the cards.',
      name: 'rulesCards',
      desc: '',
      args: [],
    );
  }

  /// `For each pair you collect, you get diamonds.`
  String get rulesGems {
    return Intl.message(
      'For each pair you collect, you get diamonds.',
      name: 'rulesGems',
      desc: '',
      args: [],
    );
  }

  /// `If an attempt is unsuccessful, you will lose one heart. When you run out of hearts, the game is over.`
  String get rulesHealth {
    return Intl.message(
      'If an attempt is unsuccessful, you will lose one heart. When you run out of hearts, the game is over.',
      name: 'rulesHealth',
      desc: '',
      args: [],
    );
  }

  /// `+{value} diamonds`
  String addGemsHint(Object value) {
    return Intl.message(
      '+$value diamonds',
      name: 'addGemsHint',
      desc: '',
      args: [value],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'ua'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
