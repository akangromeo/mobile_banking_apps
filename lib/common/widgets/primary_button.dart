import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

// Import core/theme jika Anda telah mendefinisikan warna utama di sana
// import 'package:poskit_mobile_app/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = AppColors.blueSecondary;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDesignConstants.kButtonRadius)),
          padding: padding,
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
