// Lokasi: lib/pages/pengguna/from_pemesanan.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package intl untuk format tanggal
import 'package:project_rental_mobil/pages/pengguna/pembayaran.dart';

class FormPemesanan extends StatefulWidget {
  const FormPemesanan({super.key});

  @override
  State<FormPemesanan> createState() => _FormPemesananState();
}

class _FormPemesananState extends State<FormPemesanan> {
  // State untuk menyimpan tanggal yang dipilih
  DateTime? _tanggalMulai;
  DateTime? _tanggalSelesai;

  // Objek untuk memformat tanggal
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy'); // Format: 01/01/2024

  // Fungsi untuk menampilkan DatePicker
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_tanggalMulai ?? DateTime.now())
          : (_tanggalSelesai ?? _tanggalMulai ?? DateTime.now()),
      firstDate: DateTime.now().subtract(const Duration(days: 0)), // Tidak bisa memilih hari kemarin
      lastDate: DateTime(2030),
      helpText: isStartDate ? 'Pilih Tanggal Mulai' : 'Pilih Tanggal Selesai',
      cancelText: 'Batal',
      confirmText: 'Pilih',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5A7E8C), // Warna header DatePicker
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _tanggalMulai = pickedDate;
          // Pastikan tanggal selesai tidak mendahului tanggal mulai
          if (_tanggalSelesai != null && _tanggalSelesai!.isBefore(pickedDate)) {
            _tanggalSelesai = pickedDate;
          }
        } else {
          // Pastikan tanggal selesai tidak mendahului tanggal mulai
          if (_tanggalMulai != null && pickedDate.isBefore(_tanggalMulai!)) {
            // Tampilkan pesan error jika tanggal selesai lebih awal dari tanggal mulai
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Tanggal Selesai tidak boleh mendahului Tanggal Mulai.')),
            );
          } else {
            _tanggalSelesai = pickedDate;
          }
        }
      });
    }
  }

  // Widget pembantu untuk membuat bagian input tanggal
  Widget _buildDateField({
    required String label,
    required InputDecoration decoration,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    // Teks yang akan ditampilkan di TextField
    String displayDate =
        date == null ? 'mm/ dd/ yyyy' : _dateFormat.format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap, // Panggil fungsi DatePicker saat di-tap
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            // Mengganti TextField dengan Text di dalam Container
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayDate,
                    style: TextStyle(
                      fontSize: 14,
                      color: date == null ? Colors.grey : Colors.black,
                    ),
                  ),
                  const Icon(Icons.calendar_today,
                      color: Color(0xFF5A7E8C), size: 18),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Warna-warna yang digunakan pada desain
    const Color primaryColor = Color(0xFF5A7E8C); // Warna AppBar dan Button

    // Style untuk teks harga
    final TextStyle priceTextStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Formulir Pesanan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Judul Mobil
              const Text(
                'Toyota Avanza',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),

              // Bagian Tanggal Mulai (Memanggil DatePicker untuk tanggal mulai)
              _buildDateField(
                label: 'Tanggal Mulai',
                decoration: const InputDecoration(), // Tidak digunakan lagi di versi ini
                date: _tanggalMulai,
                onTap: () => _selectDate(context, true), // isStartDate: true
              ),
              const SizedBox(height: 15),

              // Bagian Tanggal Selesai (Memanggil DatePicker untuk tanggal selesai)
              _buildDateField(
                label: 'Tanggal Selesai',
                decoration: const InputDecoration(), // Tidak digunakan lagi di versi ini
                date: _tanggalSelesai,
                onTap: () => _selectDate(context, false), // isStartDate: false
              ),
              const SizedBox(height: 30),

              // Bagian Total Harga
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total Harga:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Rp 1.050.000',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol Lanjut ke Pembayaran
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
      if (_tanggalMulai != null && _tanggalSelesai != null) {
        // Pindah ke halaman PembayaranPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PembayaranPage(), // Memanggil PembayaranPage
          ),
        );
      } else {
        // Tampilkan pesan jika tanggal belum lengkap
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Mohon lengkapi Tanggal Mulai dan Tanggal Selesai.')),
        );
      }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Lanjut ke Pembayaran',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}