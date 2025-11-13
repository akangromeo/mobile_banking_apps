import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

class GetTransactionUsecase {
  final HomeRepository repository;

  GetTransactionUsecase(this.repository);

  Future<Either<String, List<TransactionEntity>>> call() {
    return repository.getTransactions();
  }
}
