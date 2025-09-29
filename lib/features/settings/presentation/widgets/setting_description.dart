import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

/// Widget untuk menampilkan Judul dan Deskripsi di layar detail pengaturan.
class SettingDescription extends StatelessWidget {
  final String description;

  const SettingDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Tambahkan padding horizontal agar deskripsi tidak terlalu lebar
      padding: const EdgeInsets.only(
          top: 4.0, bottom: 30.0, left: 32.0, right: 32.0),
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: appTheme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
