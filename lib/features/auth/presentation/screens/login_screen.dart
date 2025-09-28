import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/keep_me_login_checkbox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png',
                      ),
                      const Spacer(),
                      Text(
                        textAlign: TextAlign.center,
                        'Login',
                        style: appTheme.textTheme.headlineMedium,
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
                              text: 'Login',
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
                            'Don’t have an Account?',
                            style: appTheme.textTheme.bodyMedium?.copyWith(
                              fontFamily: 'poppins',
                              color: AppColors.textBlack,
                            ),
                          ),
                          Text(
                            'Sign up here',
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
