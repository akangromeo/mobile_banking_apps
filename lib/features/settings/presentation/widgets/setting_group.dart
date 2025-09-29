import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;

  const SettingsSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 4.0),
        child: Text(
          title,
          style: (appTheme.textTheme.labelLarge ?? const TextStyle()).copyWith(
            color: AppColors.textGrey,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsGroup({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final Color sectionBackgroundColor = Colors.grey.shade50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(title: title),
        Column(
          children: items,
        ),
        Container(height: 20, color: sectionBackgroundColor),
      ],
    );
  }
}
