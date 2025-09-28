import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class HeadingFormText extends StatelessWidget {
  final String headingText;

  const HeadingFormText({
    super.key,
    required this.headingText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(
        horizontal: AppDesignConstants.kDefaultPadding,
      ),
      child: Text(
        headingText,
        style: const TextStyle(
          color: AppColors.textBlack,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}
