// settings_item.dart

import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

// Widget untuk setiap baris pengaturan yang bisa diklik
class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;

  // Properti baru untuk mengontrol Divider
  final bool showDivider;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.showDivider = true, // Defaultnya menampilkan Divider
  });

  @override
  Widget build(BuildContext context) {
    // Row Item yang Bisa Diklik
    final itemRow = InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        color: Colors.white,
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? AppColors.blueSecondary,
              size: 24.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: (appTheme.textTheme.bodyLarge ?? const TextStyle())
                    .copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Menggabungkan Row Item dengan Divider jika showDivider=true
    if (showDivider) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          itemRow,
        ],
      );
    }

    return itemRow; // Jika showDivider=false, kembalikan hanya itemnya
  }
}
