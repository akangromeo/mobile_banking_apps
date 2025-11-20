import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(const LoginState());

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await loginUseCase(username: username, password: password);

    result.fold(
        (failure) => emit(state.copyWith(
            status: LoginStatus.failure,
            errorMessage: failure.toString())), (user) {
      final authService = AuthService(Hive.box('authBox'));
      authService.saveToken(user.token);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    });
  }
}
