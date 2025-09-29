import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

import 'package:mobile_banking_apps/features/history/presentation/screens/history_detail_screen.dart';

import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_item.dart';

typedef TransactionData = Map<String, dynamic>;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dateKeys.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  String dateKey = dateKeys[index];
                  List<TransactionData> transactions =
                      groupedTransactions[dateKey]!;

                  final double topPadding = index == 0 ? 8.0 : 16.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: topPadding, bottom: 8.0),
                        child:
                            Text(dateKey, style: appTheme.textTheme.bodySmall),
                      ),
                      ...transactions
                          .map((tx) => TransactionItem(
                                transaction: tx,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoryDetailScreen(
                                          transactionData: tx),
                                    ),
                                  );
                                },
                              ))
                          .toList(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationUser(selectedIndex: 2),
    );
  }
}
