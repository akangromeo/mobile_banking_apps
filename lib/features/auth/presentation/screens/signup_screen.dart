import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/keep_me_login_checkbox.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        textAlign: TextAlign.center,
                        'Signup',
                        style: appTheme.textTheme.headlineMedium,
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
                              controller: emailController,
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
                            const HeadingFormText(
                                headingText: 'Confirm Password'),
                            CustomFormField(
                              labelText: 'Confirm Password',
                              controller: passwordController,
                              isPasswordField: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical:
                                        AppDesignConstants.kDefaultPadding / 2,
                                    horizontal:
                                        AppDesignConstants.kDefaultPadding,
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
                              ],
                            ),
                            const KeepMeLoginCheckBox(),
                            PrimaryButton(
                              text: 'Signup',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
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
                          Text(
                            'Sign in here',
                            style: appTheme.textTheme.labelLarge?.copyWith(
                              color: AppColors.bluePrimary,
                              fontFamily: 'poppins',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
