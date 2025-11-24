import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/custom_form_field.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/beneficiary_cubit.dart';
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
  String _selectedBankCode = "000";
  final accountNumberController = TextEditingController();
  final usernameController = TextEditingController();
  bool get _isInternalBank => _selectedBankCode == "001";
  bool _loadingShown = false;

  void _navigateToBankSelection() async {
    final result = await context.push<BankEntity>('/select-bank');

    if (result != null) {
      setState(() {
        _selectedBank = result.bankName;
        _selectedBankCode = result.bankCode;
      });
    }
  }

  void _triggerCheck() {
    if (!_isInternalBank) return;

    final acc = accountNumberController.text.trim();
    if (acc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter account number")),
      );
      return;
    }

    context.read<BeneficiaryCubit>().checkBeneficiary(
          internalAccountNumber: acc,
          amount: 0,
        );
  }

  void _showLoading(BuildContext context) {
    if (_loadingShown) return;
    _loadingShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _hideLoading(BuildContext context) {
    if (_loadingShown && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    _loadingShown = false;
  }

  void _showBeneficiaryBottomSheet(BeneficiaryEntity data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              Text(
                "Beneficiary Found",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),

              const SizedBox(height: 20),

              // BENEFICIARY NAME
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Benficiary Name",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data.fullName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                ),
              ),

              const SizedBox(height: 8),

              // ACCOUNT NUMBER
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account Number",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  data.internalAccountNumber,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    usernameController.text = data.fullName;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Use This Beneficiary",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _onNext() {
    if (_selectedBank == "Select bank") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a destination bank")),
      );
      return;
    }

    // auto beneficiary check kalau internal + sudah isi rekening
    if (_isInternalBank && usernameController.text.isEmpty) {
      _triggerCheck();
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BeneficiaryCubit, BeneficiaryState>(
      listener: (context, state) {
        if (state.status == BeneficiaryStatus.loading) {
          _showLoading(context);
        } else {
          _hideLoading(context);
        }

        if (state.status == BeneficiaryStatus.success) {
          _showBeneficiaryBottomSheet(state.data!);
        }

        if (state.status == BeneficiaryStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "Error")),
          );
        }
      },
      child: Scaffold(
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
                              style:
                                  appTheme.textTheme.headlineMedium?.copyWith(
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: AppDesignConstants.kDefaultMargin * 5,
                            ),

                            /// BANK DROPDOWN
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
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
      ),
    );
  }
}
