import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_banking_apps/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<String, UserEntity>> login(
      {required String username, required String password}) async {
    try {
      final userModel = await authRemoteDataSource.login(username, password);
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
