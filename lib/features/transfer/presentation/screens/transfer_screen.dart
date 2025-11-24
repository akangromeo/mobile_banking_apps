import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_banking_apps/core/di/injector.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/beneficiary_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_view.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BeneficiaryCubit>(),
      child: const TransferView(),
    );
  }
}
