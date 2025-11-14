import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

abstract class HomeRepository {
  Future<Either<String, BalanceEntity>> getBalance();
  Future<Either<String, List<CardEntity>>> getCards();
  Future<Either<String, List<TransactionEntity>>> getTransactions();
}
