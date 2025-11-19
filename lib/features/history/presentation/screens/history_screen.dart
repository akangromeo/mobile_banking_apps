import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/core/di/injector.dart';
import 'package:mobile_banking_apps/features/history/presentation/cubit/history_cubit.dart';
import 'package:mobile_banking_apps/features/history/presentation/screens/history_view.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HistoryCubit>()..loadHistoryData(),
      child: const HistoryView(),
    );
  }
}
