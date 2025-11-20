import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';

class GetBanksUsecase {
  final TransferRepository repository;

  GetBanksUsecase(this.repository);

  Future<Either<String, List<BankEntity>>> call() {
    return repository.getBanks();
  }
}
