import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';

class TransferSuccessScreen extends StatelessWidget {
  final TransferEntitiy data;

  const TransferSuccessScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Tombol Close di Pojok Kanan Atas ---
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 30),
                  onPressed: () {
                    context.go('/');
                  },
                ),
              ),
              const SizedBox(height: 20),

              // --- Status Sukses ---
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Transfer Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // --- Kartu Detail Struk ---
              _buildReceiptCard(data),

              const Spacer(), // Mendorong tombol ke bawah
            ],
          ),
        ),
      ),
    );
  }

  // Widget terpisah untuk kartu struk agar lebih rapi
  Widget _buildReceiptCard(TransferEntitiy data) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // --- Penerima ---
            Text('Recipient', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(
              data.recipientUname,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text('${data.externalBankName} - ${data.externalAccNumber}',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 24),

            // --- Jumlah ---
            Text('Amount', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(
              data.amount.toString(),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 28),

            // --- Tujuan Transfer ---
            Text('Transfer Purpose', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(
              data.description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
