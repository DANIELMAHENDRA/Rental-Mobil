import 'package:flutter/material.dart';
import 'package:project_rental_mobil/pages/pengguna/form_pemesanan.dart';

// Definisi Warna untuk tema
const Color primaryColor = Color(0xFF5A7E8C);     // Biru Header
const Color secondaryColor = Color(0xFF3B5B65);
const Color cardColor = Color(0xFFFFFFFF);
const Color successColor = Color(0xFF38A169); 
const Color greyTextColor = Color(0xFF6B7280);
const Color backgroundColor = Color.fromRGBO(231, 238, 243, 1); // Background Utama

// Data Model Mobil
class CarDetail {
  final String brand;
  final String licensePlate;
  final String year;
  final String transmission;
  final String capacity;
  final String status;
  final String imageUrl;
  final List<MaintenanceRecord> maintenanceHistory;
  final List<LoanRecord> loanHistory;

  CarDetail({
    required this.brand,
    required this.licensePlate,
    required this.year,
    required this.transmission,
    required this.capacity,
    required this.status,
    required this.imageUrl,
    required this.maintenanceHistory,
    required this.loanHistory,
  });
}

// Riwayat Perawatan
class MaintenanceRecord {
  final String item;
  final String date;
  MaintenanceRecord(this.item, this.date);
}

// Riwayat Peminjaman
class LoanRecord {
  final String borrower;
  final String period;
  LoanRecord(this.borrower, this.period);
}

// Mock Data
final CarDetail mockCar = CarDetail(
  brand: 'Toyota Avanza',
  licensePlate: 'B 1234 XYZ',
  year: '2023',
  transmission: 'Automatic',
  capacity: '7 Penumpang',
  status: 'Tersedia',
  imageUrl: 'https://placehold.co/300x200/5A7E8C/FFFFFF/png?text=Toyota+Avanza',
  maintenanceHistory: [
    MaintenanceRecord('Ganti Oli Terakhir:', '15/09/2025'),
    MaintenanceRecord('Servis Rem:', '01/08/2025'),
    MaintenanceRecord('Pajak Tahunan:', 'Berakhir 12/12/2025'),
  ],
  loanHistory: [
    LoanRecord('Budi Santoso', '10 Okt 2025 - 15 Okt 2025'),
    LoanRecord('Siti Aisyah', '20 Sep 2025 - 25 Sep 2025'),
  ],
);

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 238, 243, 1),  // Background utama
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(90, 126, 140, 1), // Tetap biru
        elevation: 0,
        title: const Text(
          'Detail Mobil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCarInfoCard(mockCar),
                  const SizedBox(height: 16),
                  _buildMaintenanceCard(mockCar.maintenanceHistory),
                  const SizedBox(height: 16),
                  _buildLoanHistoryCard(mockCar.loanHistory),
                ],
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FormPemesanan(),
          ),
        );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Pesan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
    );
  }

  // HEADER BIRU
  Widget _buildCarHeader() {
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(231, 238, 243, 1),
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            mockCar.imageUrl,
            height: 160,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.directions_car, size: 120, color: Colors.white);
            },
          ),
        ),
      ),
    );
  }

  // CARD INFO MOBIL
  Widget _buildCarInfoCard(CarDetail car) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              car.brand,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              car.licensePlate,
              style: const TextStyle(fontSize: 16, color: greyTextColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Tahun', car.year),
            _buildInfoRow('Transmisi', car.transmission),
            _buildInfoRow(
              'Kapasitas',
              car.capacity,
              isStatus: true,
              statusText: 'Status',
              statusValue: car.status,
              statusColor: successColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isStatus = false,
    String? statusText,
    String? statusValue,
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: greyTextColor)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          if (isStatus)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(statusText!, style: const TextStyle(color: greyTextColor)),
                Text(
                  statusValue!,
                  style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
                ),
              ],
            )
        ],
      ),
    );
  }

  // CARD PERAWATAN
  Widget _buildMaintenanceCard(List<MaintenanceRecord> history) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.settings, color: secondaryColor),
                SizedBox(width: 8),
                Text(
                  'Riwayat Perawatan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: secondaryColor),
                ),
              ],
            ),
            const Divider(),
            ...history.map((rec) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(rec.item, style: const TextStyle(color: greyTextColor)),
                      Text(rec.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // CARD PEMINJAMAN
  Widget _buildLoanHistoryCard(List<LoanRecord> history) {
    return Card(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.history, color: secondaryColor),
                SizedBox(width: 8),
                Text(
                  'Riwayat Peminjaman',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: secondaryColor),
                )
              ],
            ),
            const Divider(),
            ...history.map((rec) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec.borrower, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(rec.period, style: const TextStyle(color: greyTextColor)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// Jalankan aplikasi
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Mobil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(90, 126, 140, 1),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const CarDetailPage(),
    );
  }
}
