import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/features/transfer/data/datasources/remote/transfer_remote_datasource.dart';
import 'package:mobile_banking_apps/features/transfer/data/models/transfer_model.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/method_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDatasource transferRemoteDatasource;

  TransferRepositoryImpl({required this.transferRemoteDatasource});

  @override
  Future<Either<String, List<BankEntity>>> getBanks() async {
    try {
      final bankModel = await transferRemoteDatasource.getBanks();
      return Right(
        bankModel
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<MethodEntity>>> getMethods() async {
    try {
      final methodModel = await transferRemoteDatasource.getMethods();
      return Right(
        methodModel
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> postTransfer(TransferEntitiy payload) async {
    try {
      final result = await transferRemoteDatasource.postTransfer(
        TransferModel.fromEntity(payload),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, BeneficiaryEntity>> checkBeneficiary(
    String internalAccountNumber,
    double amount,
  ) async {
    try {
      final result = await transferRemoteDatasource.checkBeneficiary(
        amount: amount,
        internalAccountNumber: internalAccountNumber,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
