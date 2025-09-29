import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_icon_button_back.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_checkbox.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          spacing: AppDesignConstants.kDefaultMargin / 2,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthIconButtonBack(
              onPressed: () {
                context.pop();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              'Signup',
              style: appTheme.textTheme.headlineMedium?.copyWith(
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: AppDesignConstants.kDefaultMargin / 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadingFormText(headingText: 'Full Name'),
                  CustomFormField(
                    labelText: 'Full name',
                    hintText: 'Jhon Doe',
                    controller: fullNameController,
                  ),
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
                  const HeadingFormText(headingText: 'Confirm Password'),
                  CustomFormField(
                    labelText: 'Confirm Password',
                    controller: rePasswordController,
                    isPasswordField: true,
                  ),
                  const AuthCheckBox(
                    title:
                        'By Creating an Account, i accept Hiring Hub terms of Use and Privacy Policy',
                  ),
                  PrimaryButton(
                    text: 'Signup',
                    onPressed: () {},
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
                  'Have an Account?',
                  style: appTheme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'poppins',
                    color: AppColors.textBlack,
                  ),
                ),
                InkWell(
                  child: Text(
                    'Sign in here',
                    style: appTheme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.bluePrimary,
                      fontFamily: 'poppins',
                    ),
                  ),
                  onTap: () {
                    context.push('/login');
                  },
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
