import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';

import 'package:mobile_banking_apps/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);

  Future<UserModel> signup({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String password,
  });
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
        final data = response.data;

        var box = await Hive.openBox('authBox');
        box.put('session_token', data['token']);

        return UserModel.fromJson(response.data);
      } else {
        throw ServerException("Failed to login. Please Try Again.");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }

  @override
  Future<UserModel> signup({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String password,
  }) async {
    try {
      final response = await apiClient.post('/register', data: {
        'username': username,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'birthdate': birthdate,
        'password': password,
      });

      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException("Failed to signup. Please try again.");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }
}
