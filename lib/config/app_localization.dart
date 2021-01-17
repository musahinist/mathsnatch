import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class AppLocalization {
  Locale _locale;
  Map<String, String> _strings = const {};
  static final AppLocalization _instance = AppLocalization._();

  AppLocalization._();

  factory AppLocalization(Locale locale) {
    _instance._locale = locale;
    return _instance;
  }

  static String getString(String key) => _instance?._strings[key] ?? "";
  static Locale getLocale() => _instance?._locale ?? const Locale("en");

  static Future<void> updateLocale(Locale locale) async {
    if (_instance == null)
      AppLocalization(locale);
    else
      _instance._locale = locale;
    await _instance._load();
  }

  Future<void> _load() async {
    final String jsonString = await rootBundle.loadString(
      "asset/lang/${_locale.languageCode}.json",
    );
    _strings = Map.from(jsonDecode(jsonString));
  }
}
