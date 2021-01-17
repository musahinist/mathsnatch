import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageUtil {
  static const String _STORAGE_TOKEN = "token";
  static const String _STORAGE_COOKIE = "cookie";

  static Future<void> saveToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: _STORAGE_TOKEN, value: token);
  }

  static Future<String> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: _STORAGE_TOKEN);
  }

  static Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: _STORAGE_TOKEN);
  }

  static Future<void> saveCookie(String cookie) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: _STORAGE_COOKIE, value: cookie);
  }

  static Future<String> getCookie() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: _STORAGE_COOKIE);
  }

  static Future<void> deleteCookie() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: _STORAGE_COOKIE);
  }

  static Future<void> deleteAllStorage() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
