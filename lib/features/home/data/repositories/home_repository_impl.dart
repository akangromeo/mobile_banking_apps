import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImpl({required this.homeRemoteDatasource});

  @override
  Future<Either<String, BalanceEntity>> getBalance() async {
    try {
      final balanceModel = await homeRemoteDatasource.getBalance();
      return Right(balanceModel.toEntity());
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CardEntity>>> getCards() async {
    try {
      final cardsModel = await homeRemoteDatasource.getCards();

      return Right(
        cardsModel
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
  Future<Either<String, List<TransactionEntity>>> getTransactions() async {
    try {
      final transactionsModel = await homeRemoteDatasource.getTransactions();

      return Right(
        transactionsModel
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
}
