import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class KeepMeLoginCheckBox extends StatefulWidget {
  const KeepMeLoginCheckBox({super.key});

  @override
  State<KeepMeLoginCheckBox> createState() => _KeepMeLoginCheckBoxState();
}

class _KeepMeLoginCheckBoxState extends State<KeepMeLoginCheckBox> {
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
          left: AppDesignConstants.kDefaultMargin / 8,
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
            Text(
              'Keep me signed in',
              style: appTheme.textTheme.labelMedium?.copyWith(
                fontFamily: 'poppins',
                letterSpacing: 0.75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
