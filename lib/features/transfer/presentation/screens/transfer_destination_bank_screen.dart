import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class Bank {
  final String name;

  Bank({required this.name});
}

class TransferDestinationBankScreen extends StatefulWidget {
  const TransferDestinationBankScreen({super.key});

  @override
  State<TransferDestinationBankScreen> createState() =>
      _TransferDestinationBankScreenState();
}

class _TransferDestinationBankScreenState
    extends State<TransferDestinationBankScreen> {
  final List<Bank> allBanks = [
    Bank(name: 'Bank Rakyat Indonesia (BRI)'),
    Bank(name: 'Bank Central Asia (BCA)'),
    Bank(name: 'Bank Negara Indonesia (BNI)'),
  ];

  List<Bank> filteredBanks = [];

  @override
  void initState() {
    super.initState();
    filteredBanks = allBanks;
  }

  void _filterBanks(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredBanks = allBanks;
      });
    } else {
      setState(() {
        filteredBanks = allBanks
            .where(
                (bank) => bank.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                AppDesignConstants.kDefaultPadding,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _filterBanks,
                      decoration: InputDecoration(
                        hintText: 'Search banks...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.darkGray,
                        ),
                        filled: true,
                        fillColor: AppColors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppDesignConstants.kButtonRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.blueSecondary,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppDesignConstants.kButtonRadius,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignConstants.kDefaultPadding,
                vertical: AppDesignConstants.kDefaultPadding / 3,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bank List',
                  style: appTheme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filteredBanks.length,
                  itemBuilder: (context, index) {
                    final bank = filteredBanks[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, bank.name);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 16.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.grey,
                              child: Icon(
                                Icons.account_balance,
                                color: AppColors.darkGray,
                                size: 36,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                bank.name,
                                style: appTheme.textTheme.titleMedium?.copyWith(
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
