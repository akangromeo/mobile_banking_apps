import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'network_config.dart';

class ApiClient {
  final Dio _dio = NetworkConfig.createDio();
  final Box authBox;

  ApiClient(this.authBox);

  String? _getToken() {
    return authBox.get('session_token');
  }

  Map<String, dynamic> _defaultHeaders({Map<String, dynamic>? extra}) {
    return {
      'Content-Type': 'application/json',
      'X-Session-Token': _getToken(),
      ...?extra,
    };
  }

  /// GET
  Future<Response> get(String path, {Map<String, dynamic>? headers}) async {
    try {
      return await _dio.get(
        path,
        options: Options(headers: _defaultHeaders(extra: headers)),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST
  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(headers: _defaultHeaders(extra: headers)),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// PUT
  Future<Response> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        options: Options(headers: _defaultHeaders(extra: headers)),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// DELETE
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        options: Options(headers: _defaultHeaders(extra: headers)),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  AppException _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode ?? 0;
      final message =
          e.response?.data['detail'] ?? e.message ?? 'Unknown error';

      switch (statusCode) {
        case 401:
          return UnauthorizedException(message);
        case 500:
          return ServerException(message);
        default:
          return AppException(message);
      }
    } else {
      return NetworkException(e.message ?? 'Network error');
    }
  }
}
