import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> login({
    required String username,
    required String password,
  });
}
