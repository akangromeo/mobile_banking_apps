import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState {
  final SignupStatus status;
  final String? errorMessage;
  final UserEntity? user; // pakai UserEntity

  const SignupState({
    this.status = SignupStatus.initial,
    this.errorMessage,
    this.user,
  });

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
    UserEntity? user,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
