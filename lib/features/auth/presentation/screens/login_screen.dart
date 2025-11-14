import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_cubit.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_state.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_checkbox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // 🧩 Pastikan LoginUseCase sudah di-provide di atasnya (misal via get_it / MultiRepositoryProvider)
    return BlocProvider(
      create: (context) => LoginCubit(context.read<LoginUseCase>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
            );
          } else if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful')),
            );
            context.go('/'); // Ganti push → go agar tidak bisa kembali ke login
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Image.asset('assets/icons/login-image.png'),
                    const SizedBox(height: 60),
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: appTheme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeadingFormText(headingText: 'Email Address'),
                          CustomFormField(
                            labelText: 'Email',
                            hintText: 'jhondoe@gmail.com',
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const HeadingFormText(headingText: 'Password'),
                          CustomFormField(
                            labelText: 'Password',
                            controller: passwordController,
                            isPasswordField: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => context.push('/forgot-password'),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical:
                                        AppDesignConstants.kDefaultPadding / 2,
                                  ),
                                  child: Text(
                                    'Forgot Password',
                                    style:
                                        appTheme.textTheme.bodyMedium?.copyWith(
                                      color: AppColors.blueSecondary,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const AuthCheckBox(title: 'Remember Me'),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Login',
                            onPressed: state.status == LoginStatus.loading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      cubit.login(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );
                                    }
                                  },
                            isLoading: state.status == LoginStatus.loading,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an Account?',
                          style: appTheme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textBlack,
                            fontFamily: 'poppins',
                          ),
                        ),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: () => context.push('/signup'),
                          child: Text(
                            'Sign up here',
                            style: appTheme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.bluePrimary,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
