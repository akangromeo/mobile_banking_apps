import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class CustomBankDropdown extends StatelessWidget {
  final String label;
  final String selectedValue;
  final VoidCallback? onTap;

  const CustomBankDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppDesignConstants.kDefaultRadius,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignConstants.kDefaultMargin,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(
            AppDesignConstants.kDefaultRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: appTheme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  selectedValue,
                  style: appTheme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textBlack,
            ),
          ],
        ),
      ),
    );
  }
}
