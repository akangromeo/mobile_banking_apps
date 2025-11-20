import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/auth/domain/usecases/signup_usecase.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase) : super(const SignupState());

  Future<void> signup({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required String birthdate,
    required String password,
  }) async {
    emit(state.copyWith(status: SignupStatus.loading));

    final result = await signupUseCase.execute(
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      birthdate: birthdate,
      password: password,
    );

    result.fold(
      (failure) => emit(
          state.copyWith(status: SignupStatus.failure, errorMessage: failure)),
      (user) {
        emit(state.copyWith(status: SignupStatus.success, user: user));
      },
    );
  }
}
