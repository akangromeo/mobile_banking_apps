import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_item.dart';

typedef TransactionData = Map<String, dynamic>;

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  final List<TransactionData> _dummyTransactions = const [
    {
      'date': '26 Sept 2025',
      'description': 'Bank Crupt - Bill Gates',
      'accountNumber': '17023341431414141',
      'amount': 100000.0,
      'isCredit': false
    },
    {
      'date': '26 Sept 2025',
      'description': 'Bank It - Nadiem Makarim',
      'accountNumber': '17023341431414141',
      'amount': 150000.0,
      'isCredit': false
    },
    {
      'date': '25 Sept 2025',
      'description': 'Bank Que - She Kolah',
      'accountNumber': '17023341431414141',
      'amount': 200000.0,
      'isCredit': true
    },
    {
      'date': '25 Sept 2025',
      'description': 'Bank Jay - Sassuolo',
      'accountNumber': '17023341431414141',
      'amount': 50000.0,
      'isCredit': false
    },
    {
      'date': '24 Sept 2025',
      'description': 'Bank Xin - RRQ',
      'accountNumber': '17023341431414141',
      'amount': 300000.0,
      'isCredit': false
    },
  ];

  Map<String, List<TransactionData>> _groupByDate(
      List<TransactionData> transactions) {
    Map<String, List<TransactionData>> grouped = {};
    for (var tx in transactions) {
      String dateKey = tx['date'] as String;
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(tx);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactions = _groupByDate(_dummyTransactions);
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
              List<TransactionData> transactions =
                  groupedTransactions[dateKey]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: Text(dateKey, style: appTheme.textTheme.bodySmall),
                  ),
                  ...transactions
                      .map((tx) => TransactionItem(transaction: tx))
                      .toList(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
