import 'package:dartz/dartz.dart';
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

  @override
  Future<Either<String, UserEntity>> signup({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signup(
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        birthdate: birthdate,
        password: password,
      );
      return Right(user.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
