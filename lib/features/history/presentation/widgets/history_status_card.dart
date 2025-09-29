import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class HistoryStatusCard extends StatelessWidget {
  final String transactionType;
  final String status;
  final String dateTime;
  final VoidCallback onClose;

  const HistoryStatusCard({
    super.key,
    required this.transactionType,
    required this.status,
    required this.dateTime,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(AppDesignConstants.kDefaultRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Detail Transaction',
                    style: appTheme.textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                    )),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: onClose,
                ),
              ],
            ),
            Image.asset(
              'assets/icons/logo.png',
              height: 50,
              errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.check_circle_outline,
                  size: 50,
                  color: Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(transactionType,
                style: appTheme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textGrey)),
            Text(status, style: appTheme.textTheme.titleSmall),
            Text(dateTime, style: appTheme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
