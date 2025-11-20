import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> login({
    required String username,
    required String password,
  });
  Future<Either<String, UserEntity>> signup({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String password,
  });
}
