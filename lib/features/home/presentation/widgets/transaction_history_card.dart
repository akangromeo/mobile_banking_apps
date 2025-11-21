import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_item.dart';

typedef TransactionData = Map<String, dynamic>;

class TransactionHistory extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const TransactionHistory({
    super.key,
    required this.transactions,
  });

  Map<String, List<TransactionEntity>> _groupByDate(
    List<TransactionEntity> transactions,
  ) {
    Map<String, List<TransactionEntity>> grouped = {};
    for (var tx in transactions) {
      String dateKey = tx.timestamp;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(tx);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupByDate(transactions);
    final List<String> dateKeys = groupedTransactions.keys.toList();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Lastest Transactions',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                ),
          ),
          const Divider(thickness: 1, color: Colors.grey),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dateKeys.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              String dateKey = dateKeys[index];
              List<TransactionEntity> transactions =
                  groupedTransactions[dateKey]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: Text(
                      dateKey,
                      style: appTheme.textTheme.bodySmall,
                    ),
                  ),
                  ...transactions.map(
                    (tx) => TransactionItem(transaction: tx),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
