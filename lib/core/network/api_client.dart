import 'package:dio/dio.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'network_config.dart';

class ApiClient {
  final Dio _dio = NetworkConfig.createDio();

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
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
