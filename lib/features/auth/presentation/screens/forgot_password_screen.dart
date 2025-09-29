import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_icon_button_back.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          spacing: AppDesignConstants.kDefaultMargin / 2,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthIconButtonBack(
              onPressed: () {
                context.pop();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignConstants.kDefaultPadding,
              ),
              child: Text(
                'Forgot Password',
                style: appTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignConstants.kDefaultPadding,
              ),
              child: Text(
                'Enter the email address registered with your account. We`ll send you a link to reset your password.',
                style: appTheme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ),
            SizedBox(height: sHeight * 0.04),
            Form(
                key: _formKey,
                child: Column(
                  spacing: AppDesignConstants.kDefaultMargin / 2,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingFormText(headingText: 'Email Address'),
                    CustomFormField(
                      labelText: 'Email',
                      hintText: 'jhondoe@gmail.com',
                      controller: emailController,
                    ),
                    SizedBox(height: sHeight * 0.04),
                    PrimaryButton(
                      text: 'Submit',
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () {},
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
