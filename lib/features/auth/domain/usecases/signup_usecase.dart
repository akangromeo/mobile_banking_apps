import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_banking_apps/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<String, UserEntity>> execute({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate, 
    required String password,
  }) async {
    return await repository.signup(
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      birthdate: birthdate,
      password: password,
    );
  }
}
