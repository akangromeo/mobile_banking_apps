import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class BankInfoCard extends StatefulWidget {
  final String bankName;
  final String accountNumber;
  final String balance;

  const BankInfoCard({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.balance,
  });

  @override
  _BankInfoCardState createState() => _BankInfoCardState();
}

class _BankInfoCardState extends State<BankInfoCard> {
  bool _isBalanceVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignConstants.kDefaultRadius),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Menambahkan ini agar ukuran Column mengikuti child
          children: [
            // Left Section: Bank Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  height: 50,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.bankName,
                      style: appTheme.textTheme.titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    Text(
                      widget.accountNumber,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
                height: 8), // Menambahkan sedikit jarak antara baris teks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isBalanceVisible
                    ? Text(
                        'Rp ${widget.balance}',
                        style: appTheme.textTheme.titleLarge
                            ?.copyWith(color: Colors.black),
                      )
                    : const Text(
                        '****',
                        style: TextStyle(color: Colors.black),
                      ),
                IconButton(
                  icon: Icon(
                    _isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBalanceVisible = !_isBalanceVisible;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
