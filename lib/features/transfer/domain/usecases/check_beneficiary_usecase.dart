import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';

class CheckBeneficiaryUsecase {
  final TransferRepository repository;

  CheckBeneficiaryUsecase(this.repository);

  Future<Either<String, BeneficiaryEntity>> call(
    String internalAccountNumber,
    double amount,
  ) {
    return repository.checkBeneficiary(
      internalAccountNumber,
      amount,
    );
  }
}
