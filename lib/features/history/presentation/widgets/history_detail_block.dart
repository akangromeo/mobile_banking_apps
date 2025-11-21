import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

class HistoryDetailsBlock extends StatelessWidget {
  final TransactionEntity transactionData;
  final String receiverName;
  final String transferMethod;
  final String transferID;
  final double amount;
  final double transactionFee;
  final double totalTransaction;

  const HistoryDetailsBlock({
    super.key,
    required this.transactionData,
    required this.receiverName,
    required this.transferMethod,
    required this.transferID,
    required this.amount,
    required this.transactionFee,
    required this.totalTransaction,
  });

  String _formatCurrency(double amount) {
    final String formattedAmount = amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
    return 'Rp $formattedAmount';
  }

  Widget _buildDetailRow(BuildContext context, String title, String value,
      {bool isTotal = false}) {
    final TextStyle titleStyle = isTotal
        ? const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)
        : const TextStyle(color: AppColors.textGrey);

    final TextStyle valueStyle = isTotal
        ? const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)
        : const TextStyle(color: Colors.black);

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: titleStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }

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
            _buildDetailRow(context, 'Description', ''),
            Text(receiverName, style: appTheme.textTheme.titleSmall),
            const Divider(height: 30),
            _buildDetailRow(context, 'Transfer Details', ''),
            const SizedBox(height: 10),
            _buildDetailRow(context, 'Amount', _formatCurrency(amount)),
            _buildDetailRow(context, 'Transfer Method', transferMethod),
            _buildDetailRow(context, 'Transfer ID', transferID),
            _buildDetailRow(
                context, 'Transaction Fee', _formatCurrency(transactionFee)),
            const Divider(height: 30),
            _buildDetailRow(
                context, 'Total Transaction', _formatCurrency(totalTransaction),
                isTotal: true),
            const Divider(height: 30),
          ],
        ),
      ),
    );
  }
}
