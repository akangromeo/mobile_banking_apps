import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/core/di/injector.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/signup_view.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SignupCubit>(),
      child: const Scaffold(
        body: SafeArea(
          child: SignupView(),
        ),
      ),
    );
  }
}
