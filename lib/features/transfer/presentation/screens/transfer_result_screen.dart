import 'package:flutter/material.dart';

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({super.key});

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
                    // Aksi untuk kembali ke halaman utama/dashboard
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    print('Close button tapped');
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
              const SizedBox(height: 8),
              // Tanggal bisa dibuat dinamis menggunakan package intl
              Text(
                '29 Sep 2025 23:34:00 WITA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),

              // --- Kartu Detail Struk ---
              _buildReceiptCard(),

              const Spacer(), // Mendorong tombol ke bawah

              // --- Tombol Share Receipt ---
              ElevatedButton.icon(
                onPressed: () {
                  // Logika untuk share struk
                  print('Share receipt tapped');
                },
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                label: const Text(
                  'Share Receipt',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget terpisah untuk kartu struk agar lebih rapi
  Widget _buildReceiptCard() {
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
              'DEAN AGNIA'.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text('XXXXXXXX', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 4),
            Text('Bank Central Asia - XXXXX8716',
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 24),

            // --- Jumlah ---
            Text('Amount', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            const Text(
              'Rp 1.000.000',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text('from TIA MONIKA', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 24),

            // --- Tujuan Transfer ---
            Text('Transfer Purpose', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            const Text(
              'Others',
              style: TextStyle(
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
