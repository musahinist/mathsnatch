import '../../util/http/http_manager.dart';
import '../../util/http/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

abstract class AbstractService<E> {
  final String _path;
  final String _tag;
  final String baseUrl;
  final bool isAuth;
  Dio _client;

  AbstractService(
    this._path,
    this._tag, {
    this.baseUrl,
    this.isAuth = false,
  }) {
    _client = HttpManager(
      tag: _tag,
      baseUrl: baseUrl,
      isAuth: isAuth,
    ).client;
  }

  Future<Response> get({
    String innerPath = "",
    CancelToken cancelToken,
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      final response = await _client.get(
        "/$_path/$innerPath",
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  post(E entity, String innerPath) async {
    try {
      final response = await _client.post<E>("$_path/$innerPath", data: entity);
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  postCustom({
    String innerPath = "",
    CancelToken cancelToken,
    @required data,
    Map<String, dynamic> queryParameters = const {},
    Options options,
  }) async {
    try {
      final response = await _client.post(
        "/$_path/$innerPath",
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put({
    String innerPath = "",
    CancelToken cancelToken,
    Map<String, String> queryParameters = const {},
  }) async {
    try {
      final response = await _client.put(
        "/$_path/$innerPath",
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> patch({
    String innerPath = "",
    CancelToken cancelToken,
    @required data,
    Map<String, dynamic> queryParameters = const {},
    Options options,
  }) async {
    try {
      final response = await _client.patch(
        "/$_path/$innerPath",
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete({
    String innerPath = "",
    CancelToken cancelToken,
    Map<String, String> queryParameters = const {},
  }) async {
    try {
      final response = await _client.delete(
        "/$_path/$innerPath",
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      throwIfNoSuccess(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  void throwIfNoSuccess(Response response) {
    if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 299) {
      throw HttpException(response);
    }
  }
}
