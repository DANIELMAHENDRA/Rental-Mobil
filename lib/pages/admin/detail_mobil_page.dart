import 'package:flutter/material.dart';
import '../admin/dashboard_admin.dart'; // ambil model PeminjamanStatus
import 'package:project_rental_mobil/pages/pengguna/form_pemesanan.dart';

// Warna
const Color primaryColor = Color(0xFF5A7E8C);
const Color secondaryColor = Color(0xFF3B5B65);
const Color cardColor = Color(0xFFFFFFFF);
const Color successColor = Color(0xFF38A169);
const Color greyTextColor = Color(0xFF6B7280);
const Color backgroundColor = Color.fromRGBO(231, 238, 243, 1);

class CarDetailPage extends StatelessWidget {
  final PeminjamanStatus data;

  const CarDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          data.namaMobil,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImageHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCarInfoCard(),
                  const SizedBox(height: 16),
                  _buildMaintenanceCard(),
                  const SizedBox(height: 16),
                  _buildLoanHistoryCard(),
                ],
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormPemesanan()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text("Pesan", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }

  // ===================== UI ======================

  Widget _buildImageHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          data.imageUrl,
          height: 170,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCarInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.namaMobil,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: 6),

            _buildInfoRow("Nomor Polisi", data.nomorPolisi),
            _buildInfoRow("Nama Penyewa", data.namaPenyewa),
            _buildInfoRow("Status", data.isAvailable ? "Tersedia" : "Dipinjam",
                color: data.isAvailable ? successColor : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color color = greyTextColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: const TextStyle(color: greyTextColor))),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }

  // PERAWATAN (Dummy)
  Widget _buildMaintenanceCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.settings, color: secondaryColor),
                SizedBox(width: 8),
                Text("Riwayat Perawatan", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            Text("• Ganti Oli: 10/09/2025"),
            SizedBox(height: 6),
            Text("• Servis Rem: 02/06/2025"),
          ],
        ),
      ),
    );
  }

  // PEMINJAMAN (Dummy)
  Widget _buildLoanHistoryCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Row(
              children: [
                Icon(Icons.history, color: secondaryColor),
                SizedBox(width: 8),
                Text("Riwayat Peminjaman", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            Divider(),
            Text("• Rangga Saputra – 20 Sep 2025 - 23 Sep 2025"),
            SizedBox(height: 6),
            Text("• Siti Rahmawati – 10 Okt 2025 - 12 Okt 2025"),
          ],
        ),
      ),
    );
  }
}
