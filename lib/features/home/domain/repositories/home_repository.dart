import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';

abstract class HomeRepository {
  Future<BalanceEntity> getBalance();
  Future<List<CardEntity>> getCards();
  // Future<List<TransactionModel>> getTransactions();
}
