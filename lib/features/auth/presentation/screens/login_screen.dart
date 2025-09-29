import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_checkbox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset('assets/icons/login-image.png'),
              const SizedBox(
                height: 80,
              ),
              Text(
                textAlign: TextAlign.center,
                'Login',
                style: appTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  spacing: AppDesignConstants.kDefaultMargin / 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingFormText(headingText: 'Email Address'),
                    CustomFormField(
                      labelText: 'Email',
                      hintText: 'jhondoe@gmail.com',
                      controller: emailController,
                    ),
                    const HeadingFormText(headingText: 'Password'),
                    CustomFormField(
                      labelText: 'Password',
                      controller: passwordController,
                      isPasswordField: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            context.push('/forgot-password');
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppDesignConstants.kDefaultPadding / 2,
                              horizontal: AppDesignConstants.kDefaultPadding,
                            ),
                            child: Text(
                              'Forgot Password',
                              style: appTheme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.blueSecondary,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const AuthCheckBox(
                      title: 'Remmember Me',
                    ),
                    PrimaryButton(
                      text: 'Login',
                      onPressed: () {
                        context.push('/otp-screen');
                      },
                      isLoading: false,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 90),
              Row(
                spacing: AppDesignConstants.kDefaultMargin / 4,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Don’t have an Account?',
                    style: appTheme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'poppins',
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Sign up here',
                      style: appTheme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.bluePrimary,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.push('/signup');
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
