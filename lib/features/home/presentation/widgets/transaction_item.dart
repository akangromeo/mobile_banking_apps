// transaction_item.dart
import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

// Tipe data sederhana (tanpa model terpisah)
typedef TransactionData = Map<String, dynamic>;

class TransactionItem extends StatelessWidget {
  final TransactionData transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction['isCredit'] as bool;
    final double amount = transaction['amount'] as double;
    final String description = transaction['description'] as String;
    final String accountNumber = transaction['accountNumber'] as String;

    final Color amountColor = isCredit ? Colors.green : Colors.black;
    final String sign = isCredit ? '+ ' : '- ';

    final String formattedAmount = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    final String amountText = '${sign}Rp $formattedAmount';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(
            Icons.wallet,
            color: Colors.lightBlue,
            size: 24.0,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style:
                    appTheme.textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 2.0),
              Text(
                accountNumber,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          amountText,
          style: appTheme.textTheme.bodyMedium?.copyWith(
            color: amountColor,
          ),
        ),
      ],
    );
  }
}
