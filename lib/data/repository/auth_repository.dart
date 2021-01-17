import 'package:meta/meta.dart';

import '../../util/http/http_manager.dart';
import '../../util/storage_util.dart';
import '../model/user.dart';
import '../service/auth_service.dart';

class AuthenticationRepository {
  final AuthService _authService = AuthService();

  Future<void> authenticate(
    String email,
    String password,
  ) async {
    try {
      final response = await _authService.authenticate(
        email: email,
        password: password,
      );
      setToken(token: response.headers.value('X-Auth-Token'));
      //setCookie(cookie: response.headers.value("Set-Cookie"));
    } catch (e) {
      throw e;
    }
  }

  Future<void> register(
    User user,
  ) async {
    try {
      final response = await _authService.register(
        user: user,
      );

      setToken(token: response.headers.value('X-Auth-Token'));
      //     setCookie(cookie: response.headers.value("Set-Cookie"));
    } catch (e) {
      throw e;
    }
  }

  Future<User> createGuest() async {
    try {
      final response = await _authService.createGuest();
      setToken(token: response.headers.value('X-Auth-Token'));
      User user = User.fromJson(response.data);
      setUser(user: user);
      return user;
      //     setCookie(cookie: response.headers.value("Set-Cookie"));
    } catch (e) {
      throw e;
    }
  }

  Future<void> forgotPassword(
    String email,
  ) async {
    try {
      final response = await _authService.forgotPassword(
        email: email,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> hasToken() async {
    return await StorageUtil.getToken().then((token) async {
      setToken(token: token);

      if (token != null)
        return true;
      else
        return false;
    });
  }

  void setUser({@required User user}) async {
    HttpManager.user = user;
    //  HttpManager.user.photoUrl = HttpManager.user.photoUrl;
  }

  void setToken({@required String token}) {
    HttpManager.token = token;
    saveAuthData();
  }

  Future<void> saveAuthData() async {
    await StorageUtil.saveToken(HttpManager.token);
    //   return await StorageUtil.saveCookie(HttpManager.cookie);
  }

  Future<void> clearAuthData() async {
    HttpManager.token = null;
    //  HttpManager.cookie = null;
    HttpManager.user = null;
    return await StorageUtil.deleteAllStorage();
  }
}
