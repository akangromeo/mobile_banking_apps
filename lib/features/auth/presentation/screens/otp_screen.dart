import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/auth/presentation/widgets/auth_icon_button_back.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkGray),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
              const SizedBox(height: 20),
              // Bagian Header Teks

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Text(
                  'Please verify your email address',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: "We've sent an email to "),
                      TextSpan(
                        text: 'becca@gmail.com',
                        style: TextStyle(
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: ', please enter the code below.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Bagian Input OTP

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Text(
                  'Enter Code',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Pinput(
                  length: 6, // Jumlah kotak OTP
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: AppColors.blueSecondary),
                    ),
                  ),
                  onCompleted: (pin) {
                    // Aksi ketika semua kotak terisi
                    // print('OTP entered: $pin');
                  },
                ),
              ),
              const SizedBox(height: 40),

              PrimaryButton(
                text: 'Create Account',
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () {
                  context.push('/');
                },
              ),
              const SizedBox(height: 12),

              Row(
                spacing: AppDesignConstants.kDefaultMargin / 4,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Didn't see your email? ",
                    style: appTheme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'poppins',
                      color: AppColors.textBlack,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Resend',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
