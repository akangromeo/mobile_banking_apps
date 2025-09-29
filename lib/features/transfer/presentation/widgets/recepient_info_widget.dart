import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class RecipientInfoWidget extends StatelessWidget {
  final String initials;
  final String name;
  final String bankInfo;

  const RecipientInfoWidget({
    super.key,
    required this.initials,
    required this.name,
    required this.bankInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: AppColors.grey,
          foregroundColor: AppColors.textBlack,
          child: Text(
            initials,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 12),

        Text(
          name,
          style: appTheme.textTheme.headlineSmall?.copyWith(
            color: AppColors.textBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        // 3. Teks untuk info bank, dibuat lebih kecil dan berwarna abu-abu.
        Text(
          bankInfo,
          style: appTheme.textTheme.bodyLarge?.copyWith(
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
