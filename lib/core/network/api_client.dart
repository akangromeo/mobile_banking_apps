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
      final data = e.response?.data;
      String message = 'Unknown error';
      final statusCode = e.response?.statusCode ?? 0;

      if (data is Map) {
        // 1. detail.message
        if (data['detail'] is Map && data['detail']['message'] != null) {
          message = data['detail']['message'].toString();
        }
        // 2. detail langsung string
        else if (data['detail'] is String) {
          message = data['detail'];
        }
        // 3. message langsung
        else if (data['message'] != null) {
          message = data['message'].toString();
        }
        // 4. errors (misalnya validasi)
        else if (data['errors'] is Map) {
          try {
            message = data['errors'].values.map((v) => v.toString()).join(', ');
          } catch (_) {
            message = data['errors'].toString();
          }
        }
        // 5. fallback semua isi Map di-string
        else {
          message = data.toString();
        }
      } else {
        // Jika bukan Map → stringkan data atau ambil message Dio
        message = data?.toString() ?? e.message ?? 'Unknown error';
      }

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
