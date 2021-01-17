import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../../data/model/kard.dart';
import '../../data/model/topic.dart';
import '../../data/model/user.dart';
import '../log/di%C4%B1o_logger.dart';

class HttpManager {
  static String token;
  static String cookie;
  static User user;
  static List<Topic> topics;
  static List<Kard> cards;
  final String tag;
  final String baseUrl;
  final bool isAuth;

  var _dio = Dio();

  HttpManager({this.tag, this.baseUrl, this.isAuth}) {
    _dio.options..baseUrl = baseUrl ?? AppConfig.baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        if (!isAuth) {
          if (token != null) {
            options.headers["X-Auth-Token"] = "$token";
            //  options.headers["cookie"] = cookie;
          }
        }

        //TODO options.headers.update("Authentication", (v) => v = "Bearer $token", ifAbsent: () =>  "Bearer $token");
        DioLogger.onSend(tag, options);
        return options;
      },
      onResponse: (Response response) {
        DioLogger.onSuccess(tag, response);
        return response;
      },
      onError: (DioError error) {
        if (error.response.statusCode == 401) {
          //  AuthenticationBloc().add(AuthenticationLoggedOutEvent());
        }
        DioLogger.onError(tag, error);
        return error;
      },
    ));
  }

  Dio get client => _dio;
}

class Topics {}
