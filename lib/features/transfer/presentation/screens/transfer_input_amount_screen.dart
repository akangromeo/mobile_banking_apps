import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/common/widgets/primary_button.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';
import 'package:mobile_banking_apps/features/home/presentation/widgets/bank_info_card.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/custom_bank_dropdown.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/recepient_info_widget.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/widgets/transfer_back_button.dart';

class TransferDetailsScreen extends StatefulWidget {
  const TransferDetailsScreen({super.key});

  @override
  State<TransferDetailsScreen> createState() => _TransferDetailsScreenState();
}

class _TransferDetailsScreenState extends State<TransferDetailsScreen> {
  final TextEditingController _amountController =
      TextEditingController(text: '0');

  String _selectedPurpose = 'Others';

  final Map<String, String> bankData = {
    'bankName': 'Bank ABC',
    'accountNumber': '170233341431414141',
    'balance': '1.000.000',
  };

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TransferBackButton(
                pBottom: 0,
              ),
              const RecipientInfoWidget(
                initials: 'DA',
                name: 'Dean Agnia',
                bankInfo: 'Bank Central Asia - 1234567890',
              ),
              const SizedBox(height: 25),
              _buildAmountInput(),
              const SizedBox(height: 5),
              _buildSourceOfFund(),
              const SizedBox(height: 20),
              _buildTransferOptions(),
              const SizedBox(height: 30),
              PrimaryButton(
                text: 'Next',
                onPressed: () async {
                  // Logika untuk lanjut ke halaman konfirmasi
                  // Siapkan data yang akan ditampilkan di dialog
                  final String amount = 'Rp ${_amountController.text}';
                  const String fee = 'Rp 2.500'; // Contoh biaya admin
                  const String total = 'Rp 102.500'; // Contoh total

                  // Panggil dialog dan tunggu hasilnya (true jika dikonfirmasi, null jika tidak)
                  final bool? isConfirmed = await showConfirmationBottomSheet(
                    context,
                    recipientName: 'Dean Agnia',
                    recipientBankInfo: 'Bank Central Asia - 1234567890',
                    amount: amount,
                    method: 'BI Fast',
                    purpose: _selectedPurpose, // Ambil dari state
                    fee: fee,
                    total: total,
                  );

                  // Jika pengguna menekan "Continue Transfer" (isConfirmed == true)
                  if (isConfirmed == true) {
                    context.push('/transfer-input-pin');
                  }
                },
                isLoading: false,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Input Jumlah Uang
  Widget _buildAmountInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignConstants.kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: appTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rp',
                style: appTheme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: appTheme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              // Tombol 'x' untuk clear
              IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  _amountController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk Kartu Sumber Dana
  Widget _buildSourceOfFund() {
    return Container(
      color: AppColors.grey,
      child: Padding(
        padding: const EdgeInsets.all(
          AppDesignConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Source of Fund',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            BankInfoCard(
              bankName: bankData['bankName'] ?? '',
              accountNumber: bankData['accountNumber'] ?? '',
              balance: bankData['balance'] ?? '',
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Opsi Dropdown Transfer
  Widget _buildTransferOptions() {
    // Kita gunakan widget yang sama dari sebelumnya (CustomBankDropdown)
    // karena visualnya sangat mirip.
    return Padding(
      padding: const EdgeInsets.all(
        AppDesignConstants.kDefaultPadding,
      ),
      child: Column(
        children: [
          CustomBankDropdown(
            label: 'Transfer Method',
            selectedValue: 'BI Fast',
            onTap: () {
              // Logika untuk menampilkan pilihan metode transfer
            },
          ),
          const SizedBox(height: 16),
          CustomBankDropdown(
            label: 'Transfer Purpose',
            selectedValue: _selectedPurpose,
            onTap: () async {
              final result = await showTransferPurposeBottomSheet(
                context,
                currentPurpose: _selectedPurpose,
              );

              if (result != null) {
                setState(() {
                  _selectedPurpose = result;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

// Ganti fungsi lama dengan yang ini
Future<String?> showTransferPurposeBottomSheet(
  BuildContext context, {
  // Tambahkan parameter untuk menerima pilihan yang sedang aktif
  required String currentPurpose,
}) {
  final List<String> purposes = [
    'Others',
    'Investment',
    'Wealth Transfer',
    'Payment'
  ];

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Bagian Header (Tetap Sama) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pick Transfer Purpose',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
              const SizedBox(height: 20),

              // --- Daftar Pilihan (Logika Diperbarui) ---
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: purposes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final purpose = purposes[index];
                  // PERUBAHAN: Logika untuk menentukan tombol mana yang sedang dipilih
                  final bool isSelected = purpose == currentPurpose;

                  return InkWell(
                    onTap: () {
                      Navigator.pop(context, purpose);
                    },
                    borderRadius: BorderRadius.circular(12),
                    // PERUBAHAN: Efek visual saat tombol ditekan (On Click)
                    splashColor: Colors.blue.withOpacity(0.1),
                    highlightColor: Colors.blue.withOpacity(0.05),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        // PERUBAHAN: Gaya berdasarkan kondisi isSelected
                        border: isSelected
                            ? Border.all(
                                color: Colors.blue,
                                width: 1.5) // Selected State
                            : Border.all(
                                color: Colors.grey.shade300), // Default State
                        boxShadow: isSelected
                            ? []
                            : [
                                // Shadow halus untuk Default State
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.08),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                ),
                              ],
                      ),
                      child: Center(
                        child: Text(
                          purpose,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            // PERUBAHAN: Warna teks berdasarkan kondisi isSelected
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Letakkan fungsi ini di dalam file transfer_details_screen.dart

// Helper widget kecil untuk baris detail agar kode tidak berulang
Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

// FUNGSI BARU UNTUK BOTTOM SHEET KONFIRMASI
Future<bool?> showConfirmationBottomSheet(
  BuildContext context, {
  required String recipientName,
  required String recipientBankInfo,
  required String amount,
  required String method,
  required String purpose,
  required String fee,
  required String total,
}) {
  // Menggunakan showModalBottomSheet, bukan showDialog
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true, // Penting agar tinggi bisa menyesuaikan
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      // SafeArea agar tidak mentok status bar atas
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Tinggi sesuai konten
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Judul ---
              const Text(
                'Transfer Confirmation',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // --- Info Penerima ---
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFF3F4F6),
                    child: Text('DA',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipientName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(recipientBankInfo,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const Divider(height: 30),

              // --- Detail Transfer ---
              _buildDetailRow('Transfer Amount', amount, isBold: true),
              _buildDetailRow('Transfer Method', method),
              _buildDetailRow('Transfer Purpose', purpose),
              _buildDetailRow('Transaction Fee', fee),
              const SizedBox(height: 12),

              // --- Sumber Dana ---
              Text('Source of Fund',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bank Name - 17023341431414141',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text('Rp xx.xxx.xxx',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Tombol Aksi ---
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Continue Transfer',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    Text(total,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
