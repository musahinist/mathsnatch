import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class PrefUtil {
  static const String _LANGUAGE = "language";
  static const String _THEME = "theme";
  static const String _DEFAULT_LANGUAGE = "en";
  static const String _OPENNING = "openning";
  static const String _GAME_STATE = "gameState";

  ///
  /// 0: LIGHT
  /// 1: DARK
  /// 2: ORANGE
  ///
  static Future<void> saveTheme(int themeIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_THEME, themeIndex);
  }

  static Future<int> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_THEME) ?? 0;
  }

  static Future<void> saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_LANGUAGE, languageCode.toLowerCase());
  }

  static Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_LANGUAGE) ?? _DEFAULT_LANGUAGE;
  }

  static Future<void> saveFirstOpenning() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_OPENNING, false);
  }

  static Future<bool> getIsFirstOpenning() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_OPENNING) ?? true;
  }

  static Future<void> saveGameState(
      {String topicId, String cardId, String videoId}) async {
    final box = GetStorage();
    box.write(_GAME_STATE,
        {"topicId": topicId, "cardId": cardId, "videoId": videoId});
  }

  static Map<String, dynamic> getGameState() {
    final box = GetStorage();
    return box.read(_GAME_STATE);
  }
}
