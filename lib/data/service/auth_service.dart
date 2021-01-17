import 'package:deneme/util/http/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../model/user.dart';
import 'abstract_service.dart';

class AuthService extends AbstractService {
  final String path;
  final String tag;

  AuthService({
    this.path = "auth",
    this.tag = "AuthService",
  }) : super(path, tag, isAuth: true);

  Future<Response> authenticate({
    @required String email,
    @required String password,
  }) async {
    assert(email != null);
    assert(password != null);

    try {
      var cancelToken = CancelToken();
      final response = await postCustom(
        // innerPath: '',
        queryParameters: {"user_id": HttpManager.user.sId},
        data: {
          'email': '$email',
          'password': '$password',
        },
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> createGuest() async {
    try {
      final response = await get(
        innerPath: 'guest',
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> register({
    @required User user,
  }) async {
    assert(user != null);

    try {
      final response = await postCustom(
        innerPath: 'register',
        data: user,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> forgotPassword({
    @required String email,
  }) async {
    assert(email != null);

    var cancelToken = CancelToken();
    try {
      final response = await get(
        innerPath: 'forgotPassword',
        queryParameters: {'email': '$email'},
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
