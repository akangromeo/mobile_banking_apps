import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/custom_bank_dropdown.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/transfer_back_button.dart';

class TransferView extends StatefulWidget {
  const TransferView({super.key});

  @override
  State<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends State<TransferView> {
  String _selectedBank = "Select bank";
  final accountNumberController = TextEditingController();
  final usernameController = TextEditingController();

  void _navigateToBankSelection() async {
    final result = await context.push<String>('/select-bank');

    if (result != null) {
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
                  controller: accountNumberController,
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  keyboardType: TextInputType.name,
                  labelText: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 200),
                PrimaryButton(
                  text: 'Next',
                  onPressed: () {
                    context.push(
                      '/transfer-input-amount',
                      extra: {
                        "bank": _selectedBank,
                        "accountNumber": accountNumberController.text,
                        "username": usernameController.text,
                      },
                    );
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
