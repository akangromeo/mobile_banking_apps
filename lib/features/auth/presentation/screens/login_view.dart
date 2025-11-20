import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_cubit.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_state.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_checkbox.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed')),
          );
        } else if (state.status == LoginStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
          context.go('/');
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
                  const SizedBox(height: 60),
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
                        const HeadingFormText(headingText: 'Username'),
                        CustomFormField(
                          labelText: 'Username',
                          hintText: 'jhondoe',
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
                                // child: Text(
                                //   'Forgot Password',
                                //   style:
                                //       appTheme.textTheme.bodyMedium?.copyWith(
                                //     color: AppColors.blueSecondary,
                                //     fontFamily: 'poppins',
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
    );
  }
}
