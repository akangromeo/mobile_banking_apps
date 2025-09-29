import 'package:flutter/material.dart';

import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/history/presentation/widgets/history_detail_block.dart';
import 'package:mobile_banking_apps/features/history/presentation/widgets/history_status_card.dart';

typedef TransactionData = Map<String, dynamic>;

class HistoryDetailScreen extends StatelessWidget {
  final TransactionData transactionData;

  const HistoryDetailScreen({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    final String transactionType = 'IDR Transfer';
    final String status = 'Transfer Successful';
    final String dateTime = '26 Sept 2025 | 22:40';
    final String transferMethod = 'BI Fast';
    final String transferID = 'TFID';
    final double transactionFee = 2500.0;

    final String receiverName =
        transactionData['description'].toString().split(' - ').last;
    final double amount = transactionData['amount'] as double;
    final double totalTransaction = amount + transactionFee;

    final String sourceName = 'Name';
    final String sourceAccount = 'Bank Name - 1233313113';

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            HistoryStatusCard(
              transactionType: transactionType,
              status: status,
              dateTime: dateTime,
              onClose: () => Navigator.of(context).pop(),
            ),
            HistoryDetailsBlock(
              transactionData: transactionData,
              receiverName: receiverName,
              sourceAccount: sourceAccount,
              transferMethod: transferMethod,
              transferID: transferID,
              amount: amount,
              transactionFee: transactionFee,
              totalTransaction: totalTransaction,
              sourceName: sourceName,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
