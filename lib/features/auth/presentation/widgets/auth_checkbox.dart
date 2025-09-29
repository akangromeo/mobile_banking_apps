import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class AuthCheckBox extends StatefulWidget {
  final String title;

  const AuthCheckBox({
    super.key,
    required this.title,
  });

  @override
  State<AuthCheckBox> createState() => _AuthCheckBoxState();
}

class _AuthCheckBoxState extends State<AuthCheckBox> {
  bool _isChecked = false;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleCheckbox,
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDesignConstants.kDefaultMargin,
          left: AppDesignConstants.kDefaultMargin / 8,
          right: AppDesignConstants.kDefaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                _toggleCheckbox();
              },
              activeColor: AppColors.success,
            ),
            Flexible(
              child: Text(
                widget.title,
                style: appTheme.textTheme.labelMedium?.copyWith(
                  fontFamily: 'poppins',
                  letterSpacing: 0.75,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
