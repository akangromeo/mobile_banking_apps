import 'package:flutter/material.dart';

import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/history/presentation/widgets/history_detail_block.dart';
import 'package:mobile_banking_apps/features/history/presentation/widgets/history_status_card.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

class HistoryDetailScreen extends StatelessWidget {
  final TransactionEntity transactionData;

  const HistoryDetailScreen({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    final String receiverName =
        transactionData.description.toString().split(' - ').last;
    final double amount = transactionData.amount;
    final double totalTransaction = amount;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            HistoryStatusCard(
              transactionType: transactionData.type,
              status: transactionData.status,
              dateTime: transactionData.timestamp,
              onClose: () => Navigator.of(context).pop(),
            ),
            HistoryDetailsBlock(
              transactionData: transactionData,
              receiverName: receiverName,
              transferMethod: transactionData.timestamp,
              transferID: transactionData.id.toString(),
              amount: amount,
              //todo no transaction fee
              transactionFee: 0,
              totalTransaction: totalTransaction,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
