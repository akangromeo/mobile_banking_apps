import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_icon_button_back.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/heading_form_text.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_checkbox.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/signup_state.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectBirthdate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted = DateFormat("d MMMM yyyy", "en").format(picked);

      birthdateController.text = formatted;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign up failed')),
          );
        } else if (state.status == SignupStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up successful')),
          );
          context.go('/login');
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDesignConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Sign up',
                textAlign: TextAlign.center,
                style: appTheme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingFormText(headingText: 'Username'),
                    CustomFormField(
                      labelText: 'username',
                      hintText: 'JohnDoe',
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        if (value.length < 4) {
                          return 'Username must be at least 4 characters';
                        }
                        return null;
                      },
                    ),
                    const HeadingFormText(headingText: 'First Name'),
                    CustomFormField(
                      labelText: 'First Name',
                      hintText: 'John',
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const HeadingFormText(headingText: 'Last Name'),
                    CustomFormField(
                      labelText: 'Last Name',
                      hintText: 'Doe',
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const HeadingFormText(headingText: 'Birthdate'),
                    GestureDetector(
                      onTap: _selectBirthdate,
                      child: AbsorbPointer(
                        child: CustomFormField(
                          labelText: 'Birthdate',
                          hintText: '12 October 2000',
                          controller: birthdateController,
                          suffixIcon: Icons.calendar_month,
                          onSuffixIconPressed: _selectBirthdate,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Birthdate cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const HeadingFormText(headingText: 'Email Address'),
                    CustomFormField(
                      labelText: 'Email',
                      hintText: 'johndoe@gmail.com',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email';
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
                          return 'Password cannot be empty';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const HeadingFormText(headingText: 'Confirm Password'),
                    CustomFormField(
                      labelText: 'Confirm Password',
                      controller: rePasswordController,
                      isPasswordField: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Sign up',
                      isLoading: state.status == SignupStatus.loading,
                      onPressed: state.status == SignupStatus.loading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignupCubit>().signup(
                                      username: usernameController.text.trim(),
                                      firstName:
                                          firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      birthdate:
                                          birthdateController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                              }
                            },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an Account?',
                    style: appTheme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'poppins',
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    child: Text(
                      'Sign in here',
                      style: appTheme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.bluePrimary,
                        fontFamily: 'poppins',
                      ),
                    ),
                    onTap: () => context.push('/login'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
