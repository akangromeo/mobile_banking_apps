import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class AuthIconButtonBack extends StatelessWidget {
  final VoidCallback onPressed;
  const AuthIconButtonBack({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.bluePrimary.withAlpha(45),
              foregroundColor: AppColors.textBlack,
            ),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textBlack,
              size: 18,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
