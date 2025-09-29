import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/transfer_back_button.dart';
import 'package:pinput/pinput.dart';

class TransferInputPinScreen extends StatelessWidget {
  const TransferInputPinScreen({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TransferBackButton(),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Text(
                  'Enter Your Pin',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignConstants.kDefaultPadding,
                ),
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: AppColors.blueSecondary),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) {
                    // Aksi ketika semua kotak terisi
                    // print('OTP entered: $pin');
                  },
                ),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: 'Confirm PIN',
                padding: const EdgeInsets.symmetric(vertical: 16),
                onPressed: () {
                  context.push('/transfer-result-success');
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
