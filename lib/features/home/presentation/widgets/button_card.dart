import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class ButtonCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const ButtonCard({
    Key? key,
    required this.iconData,
    required this.text,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = (screenWidth - AppDesignConstants.kDefaultPadding) / 2.2;
    final Color mainColor = color ?? Colors.lightBlue.shade300;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              size: 28.0,
              color: AppColors.blueSecondary,
            ),
            const SizedBox(height: 10.0),
            Text(text,
                style: appTheme.textTheme.bodyLarge
                    ?.copyWith(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
