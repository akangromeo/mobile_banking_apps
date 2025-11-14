import 'package:dio/dio.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/features/home/data/models/balance_model.dart';
import 'package:mobile_banking_apps/features/home/data/models/card_model.dart';
import 'package:mobile_banking_apps/features/home/data/models/transaction_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<CardModel>> getCards();
  Future<BalanceModel> getBalance();
  Future<List<TransactionModel>> getTransactions();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiClient apiClient;

  HomeRemoteDatasourceImpl(this.apiClient);

  @override
  Future<BalanceModel> getBalance() async {
    try {
      //todo nanti ngambil dari hive/local storage
      const token = 'ca21ab16-8881-4225-ad84-63350c5162a1';
      final response = await apiClient.get('/user/balance', headers: {
        'X-Session-Token': token,
      });

      if (response.statusCode == 200) {
        return BalanceModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to get Card Balance');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }

  @override
  Future<List<CardModel>> getCards() async {
    try {
      //todo nanti ngambil dari hive/local storage
      const token = 'ca21ab16-8881-4225-ad84-63350c5162a1';
      final response = await apiClient.get('/user/cards', headers: {
        'X-Session-Token': token,
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => CardModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to get Cards');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Unknown Error.");
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  // @override
  // Future<List<TransactionModel>> getTransactions() async {
  //   // try {
  //   //   //todo nanti ngambil dari hive/local storage
  //   //   final token = '';
  //   //   final response = await apiClient.get('/user/transactions', headers: {
  //   //     'X-Session-Token': token,
  //   //   });

  //   //   if (response.statusCode == 200) {
  //   //     final List<dynamic> data = response.data;
  //   //     return data.map((json) => TransactionModel.fromJson(json)).toList();
  //   //   } else {
  //   //     throw ServerException('Failed to get Cards');
  //   //   }
  //   // } on DioException catch (e) {
  //   //   throw ServerException(e.message ?? "Unknown Error.");
  //   // }
  // }
}
