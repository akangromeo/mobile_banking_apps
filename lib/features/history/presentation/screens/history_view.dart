import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/common/widgets/bottom_navigation_user.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/history/presentation/cubit/history_cubit.dart';

import 'package:mobile_banking_apps/features/history/presentation/screens/history_detail_screen.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

import 'package:mobile_banking_apps/features/home/presentation/widgets/transaction_item.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
      ),
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            final transactions = state.transactions;
            final groupedTransactions = _groupByDate(transactions);
            final List<String> dateKeys = groupedTransactions.keys.toList();
            return SingleChildScrollView(
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
                        List<TransactionEntity> transactions =
                            groupedTransactions[dateKey]!;

                        final double topPadding = index == 0 ? 8.0 : 16.0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: topPadding, bottom: 8.0),
                              child: Text(dateKey,
                                  style: appTheme.textTheme.bodySmall),
                            ),
                            ...transactions
                                .map((tx) => TransactionItem(
                                      transaction: tx,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryDetailScreen(
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
            );
          } else if (state is HistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: const BottomNavigationUser(selectedIndex: 2),
    );
  }
}
