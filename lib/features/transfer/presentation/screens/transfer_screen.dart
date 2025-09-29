import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_destination_bank_screen.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/custom_bank_dropdown.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/transfer_back_button.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String _selectedBank = "Select bank";

  void _navigateToBankSelection() async {
    // Navigasi ke BankListScreen dan tunggu hasilnya (hasilnya bisa berupa String atau null)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransferDestinationBankScreen(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _selectedBank = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              AppDesignConstants.kDefaultPadding / 2,
            ),
            child: Column(
              children: [
                const TransferBackButton(
                  pBottom: 0,
                ),
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.grey,
                  foregroundColor: AppColors.textBlack,
                  child: Icon(
                    Icons.send_to_mobile,
                    size: 45,
                  ),
                ),
                const SizedBox(height: AppDesignConstants.kDefaultMargin),
                Text(
                  textAlign: TextAlign.center,
                  'Transfer to New Recipient',
                  style: appTheme.textTheme.headlineMedium?.copyWith(
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: AppDesignConstants.kDefaultMargin * 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CustomBankDropdown(
                    label: 'Destination Bank',
                    selectedValue: _selectedBank,
                    onTap: _navigateToBankSelection,
                  ),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  keyboardType: TextInputType.number,
                  labelText: 'Account Number',
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 350),
                PrimaryButton(
                  text: 'Next',
                  onPressed: () {
                    context.push('/transfer-input-amount');
                  },
                  isLoading: false,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
