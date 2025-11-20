import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/transfer/data/models/bank_model.dart';
import 'package:mobile_banking_apps/features/transfer/data/models/method_model.dart';
import 'package:mobile_banking_apps/features/transfer/data/models/transfer_model.dart';

abstract class TransferRemoteDatasource {
  Future<List<BankModel>> getBanks();
  Future<List<MethodModel>> getMethods();
  Future<String> postTransfer(TransferModel transfer);
}

class TransferRemoteDatasourceImpl implements TransferRemoteDatasource {
  final ApiClient apiClient;
  final AuthService authService;

  TransferRemoteDatasourceImpl({
    required this.apiClient,
    required this.authService,
  });

  @override
  Future<List<BankModel>> getBanks() async {
    try {
      final response = await apiClient.get('/banks');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['available_banks'];
        return data.map((json) => BankModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to get List Bank');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }

  @override
  Future<List<MethodModel>> getMethods() async {
    try {
      final response = await apiClient.get('/banks');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['supported_methods'];
        return data.map((json) => MethodModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to get list method');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }

  @override
  Future<String> postTransfer(TransferModel transfer) async {
    try {
      final token = authService.token;
      final response = await apiClient.post(
        '/user/transaction/transfer',
        headers: {
          'X-Session-Token': token,
        },
        data: transfer.toJson(),
      );

      if (response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw ServerException('Transfer failed');
      }
    } on DioException catch (e) {
      final data = e.response?.data;

      String serverMsg = 'Unknown Error';

      if (data is Map<String, dynamic>) {
        // Case API kamu
        if (data['detail'] is Map<String, dynamic>) {
          final detail = data['detail'];
          serverMsg = detail['message']?.toString() ?? 'Unknown Error';
        }

        // fallback: {message: "..."}
        else if (data['message'] != null) {
          serverMsg = data['message'].toString();
        }

        // fallback: map lainnya
        else {
          serverMsg = data.toString();
        }
      } else {
        serverMsg = data?.toString() ?? 'Unknown Error';
      }

      throw ServerException(serverMsg);
    }
  }
}
