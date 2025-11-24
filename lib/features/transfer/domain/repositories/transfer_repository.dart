import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/method_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';

abstract class TransferRepository {
  Future<Either<String, List<BankEntity>>> getBanks();
  Future<Either<String, List<MethodEntity>>> getMethods();
  Future<Either<String, String>> postTransfer(TransferEntitiy payload);
  Future<Either<String, BeneficiaryEntity>> checkBeneficiary(
    String internalAccountNumber,
    double amount,
  );
}
