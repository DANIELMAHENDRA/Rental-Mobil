import 'package:flutter/material.dart';
import '../../theme/colors.dart'; // Import AppColors
import '../../models/user_model.dart'; // <<< WAJIB DIIMPORT UNTUK MENGGUNAKAN TIPE USERMODEL
import 'detail_mobil_page.dart';

// Model data tiruan untuk menampilkan daftar mobil
class PeminjamanStatus {
  final String namaMobil;
  final String nomorPolisi;
  final String namaPenyewa;
  final bool isAvailable;
  final String imageUrl;

  PeminjamanStatus({
    required this.namaMobil,
    required this.nomorPolisi,
    required this.namaPenyewa,
    required this.isAvailable,
    required this.imageUrl,
  });
}

// Data tiruan yang akan ditampilkan
final List<PeminjamanStatus> mockData = [
  PeminjamanStatus(
    namaMobil: "AVANZA",
    nomorPolisi: "B 1234 XY",
    namaPenyewa: "Rangga Saputra",
    isAvailable: true,
    imageUrl: 'assets/image/Avanza1.jpg',
  ),
  PeminjamanStatus(
    namaMobil: "EXPANDER",
    nomorPolisi: "D 5678 ZI",
    namaPenyewa: "Siti Rahmawati",
    isAvailable: false,
    imageUrl: 'assets/image/expander.jpeg', 
  ),
  PeminjamanStatus(
    namaMobil: "HYUNDAI",
    nomorPolisi: "B 9012 AA",
    namaPenyewa: "Andi Wijaya",
    isAvailable: true,
    imageUrl: 'assets/image/hyundai.jpeg', 
  ),
  PeminjamanStatus(
    namaMobil: "PAJERO",
    nomorPolisi: "B 3456 BC",
    namaPenyewa: "Budi Santoso",
    isAvailable: false,
    imageUrl: 'assets/image/Pajero.jpeg', 
  ),

    PeminjamanStatus(
    namaMobil: "Rush",
    nomorPolisi: "B 9008 BC",
    namaPenyewa: "Daniel",
    isAvailable: false,
    imageUrl: 'assets/image/Rush.jpeg', 
  ),
];

// List menu admin untuk GridView
final List<Map<String, dynamic>> adminMenu = [
  {'title': 'Pelanggan', 'icon': Icons.people_alt_outlined},
  {'title': 'Mobil', 'icon': Icons.directions_car_outlined},
  {'title': 'Laporan', 'icon': Icons.leaderboard_outlined},
  {'title': 'Verifikasi Pembayaran', 'icon': Icons.payment_outlined},
];


class DashboardAdmin extends StatelessWidget {
  final UserModel user;

  // 2. PERBAIKI KONSTRUKTOR UNTUK MEMINTA USER
  const DashboardAdmin({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian Atas: Header dan Menu Grid
            _buildHeaderAndMenu(context), // Tidak perlu passing user di sini, karena sudah ada di scope class
            
            // Bagian Bawah: Status Peminjaman
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Status Peminjaman",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Daftar Status Peminjaman
                  ...mockData.map((data) => _buildStatusCard(context, data)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun Header dan Grid Menu (Area Oranye)
  Widget _buildHeaderAndMenu(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary, // Warna background atas (Hijau Gelap)
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Hamburger Menu & Judul)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(Icons.menu, color: AppColors.textWhite, size: 30),
                const SizedBox(width: 15),
                // Gunakan data user untuk menyambut pengguna
                Text(
                  "Selamat Datang, ${user.username}", // <<< PERUBAHAN DI SINI
                  style: const TextStyle(
                    fontSize: 20, // Mengurangi sedikit ukuran font agar lebih pas
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Container Oranye untuk Grid Menu
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accent, // Warna Oranye
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Menonaktifkan scroll GridView
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.5, // Rasio agar kartu lebih lebar
                ),
                itemCount: adminMenu.length,
                itemBuilder: (context, index) {
                  return _buildMenuItem(
                    adminMenu[index]['title']!,
                    adminMenu[index]['icon']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk setiap item Menu (Pelanggan, Mobil, dll.)
  Widget _buildMenuItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.textWhite, // Kartu menu berwarna putih
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: AppColors.statusDark),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Kartu Status Peminjaman
  Widget _buildStatusCard(BuildContext context, PeminjamanStatus data) {
    // Pilih warna background berdasarkan index (sesuai pola di gambar)
    final bool isDark = mockData.indexOf(data) % 2 == 0;
    final Color bgColor = isDark ? AppColors.statusDark : AppColors.statusLight;
    final Color textColor = isDark ? AppColors.textWhite : AppColors.textDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Mobil (AVANZA)
          Text(
            data.namaMobil,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 10),
          
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Gambar Mobil
    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        data.imageUrl,
        width: 100,
        height: 70,
        fit: BoxFit.cover,
      ),
    ),

    const SizedBox(width: 15),

    // Detail Status + Button Detail
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow("Nomor Polisi:", data.nomorPolisi, textColor),
          _buildDetailRow("Nama Penyewa:", data.namaPenyewa, textColor),
          _buildDetailRow("Status:", data.isAvailable ? "Tersedia" : "Dipinjam", textColor),

          const SizedBox(height: 10),

          // ================= BUTTON DETAIL ORANYE =================
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CarDetailPage(data: data),
                ),
              );

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                decoration: BoxDecoration(
                  color: Color(0xFFFF8A50), // WARNA ORANYE
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Detail",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    // Indikator Status Kuning
    Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
        ),
      ),
    ),
  ],
)

        ],
      ),
    );
  }

  // Widget pembantu untuk baris detail
  Widget _buildDetailRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: color),
          children: <TextSpan>[
            TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.w500)),
            TextSpan(text: ' $value'),
          ],
        ),
      ),
    );
  }
}