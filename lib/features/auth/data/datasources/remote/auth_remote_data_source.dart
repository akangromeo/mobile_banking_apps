import 'package:dio/dio.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';

import 'package:mobile_banking_apps/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await apiClient.post('/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException("Failed to login. Please Try Again.");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }
}
