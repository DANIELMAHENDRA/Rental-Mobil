// Lokasi: lib/pages/pengguna/pembayaran.dart

import 'package:flutter/material.dart';
import 'payment_success_page.dart';



class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna-warna yang digunakan pada desain
    const Color primaryColor = Color(0xFF5A7E8C); // Warna AppBar
    const Color buttonColor = Color(0xFFF3A78D); // Warna tombol Konfirmasi

    return Scaffold(
      appBar: AppBar(
        // Menggunakan warna background yang mendekati pada gambar
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false, // Judul rata kiri
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- 1. Kartu Total Tagihan ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Total Tagihan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp 1.050.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // --- 2. Judul Metode Pembayaran ---
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // --- 3. Dropdown Metode Pembayaran (Menggunakan DropdownButton) ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: 'QRIS', // Nilai default yang ditampilkan
                    icon: const Icon(Icons.keyboard_arrow_down, color: primaryColor),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    items: <String>['QRIS', 'Transfer Bank', 'Virtual Account']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Di sini Anda bisa menambahkan logika untuk mengubah state
                      // Namun karena ini StatelessWidget, kita hanya mencetak log
                      print('Metode Pembayaran dipilih: $newValue');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- 4. Upload Bukti Pembayaran ---
              const Text(
                'Upload Bukti Pembayaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Field Upload File
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    // Tombol 'Choose File'
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Choose File',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Teks 'No file chosen'
                    const Text(
                      'No file chosen',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // --- 5. Tombol Konfirmasi Pembayaran ---
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                MaterialPageRoute(
                  builder: (context) => const PaymentSuccessPage(),
                ),
              );
                  print('Konfirmasi Pembayaran ditekan');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor, // Warna oranye lembut
                  minimumSize: const Size(double.infinity, 55), // Lebar penuh
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Sudut membulat
                  ),
                ),
                child: const Text(
                  'Konfirmasi Pembayaran',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}