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
  final _formKey = GlobalKey<FormState>();

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

  void _onNext() {
    if (_selectedBank == "Select bank") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a destination bank")),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      context.push(
        '/transfer-input-amount',
        extra: {
          "bank": _selectedBank,
          "accountNumber": accountNumberController.text,
          "username": usernameController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppDesignConstants.kDefaultPadding / 2,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const TransferBackButton(
                            pBottom: 0,
                            destination: "/",
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
                          const SizedBox(
                              height: AppDesignConstants.kDefaultMargin),
                          Text(
                            'Transfer to New Recipient',
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.headlineMedium?.copyWith(
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: AppDesignConstants.kDefaultMargin * 5,
                          ),

                          /// BANK DROPDOWN
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Account number cannot be empty";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          CustomFormField(
                            keyboardType: TextInputType.name,
                            labelText: 'Beneficiary Name',
                            controller: usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Beneficiary Name cannot be empty";
                              }
                              return null;
                            },
                          ),

                          const Spacer(),

                          PrimaryButton(
                            text: 'Next',
                            onPressed: _onNext,
                            isLoading: false,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
