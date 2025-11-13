import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

class GetBalanceUsecase {
  final HomeRepository repository;

  GetBalanceUsecase(this.repository);

  Future<Either<String, BalanceEntity>> call() {
    return repository.getBalance();
  }
}
