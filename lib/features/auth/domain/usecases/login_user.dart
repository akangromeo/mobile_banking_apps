import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_banking_apps/features/auth/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<String, UserEntity>> call({
    required String username,
    required String password,
  }) {
    return repository.login(username: username, password: password);
  }
}
