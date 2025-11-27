import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../models/user_model.dart';
import 'package:project_rental_mobil/pages/pengguna/detail_mobil_page.dart';
import 'package:project_rental_mobil/pages/pengguna/car_search_page.dart';

// Model mobil
class CarModel {
  final String name;
  final String specs;
  final String pricePerDay;
  final String imageUrl;
  final bool isBooked;

  CarModel({
    required this.name,
    required this.specs,
    required this.pricePerDay,
    required this.imageUrl,
    this.isBooked = false,
  });
}

// Mock data
final List<CarModel> mockCars = [
  CarModel(
    name: "Honda CRV",
    specs: "4 Penumpang",
    pricePerDay: "550.000",
    imageUrl: 'https://placehold.co/400x300/CCCCCC/333333?text=Honda+CRV',
  ),
  CarModel(
    name: "Toyota Avanza",
    specs: "4 Penumpang",
    pricePerDay: "550.000",
    imageUrl: 'https://placehold.co/400x300/CCCCCC/333333?text=Toyota+Avanza',
    isBooked: true,
  ),
  CarModel(
    name: "Honda Jazz",
    specs: "4 Penumpang",
    pricePerDay: "450.000",
    imageUrl: 'https://placehold.co/400x300/CCCCCC/333333?text=Honda+Jazz',
  ),
  CarModel(
    name: "SUV Mewah",
    specs: "7 Penumpang",
    pricePerDay: "800.000",
    imageUrl: 'https://placehold.co/400x300/CCCCCC/333333?text=Luxury+SUV',
  ),
];

class DashboardUser extends StatelessWidget {
  final UserModel user;

  const DashboardUser({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ===================== HEADER BIRU =====================
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 86,
                          height: 86,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Logo",
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===================== KONTEN PUTIH =====================
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),

                      Text(
                        "Selamat Datang, ${user.username}!",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 139, 74),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ===================== SEARCH BAR =====================
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CarSearchPage()),
                          );
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 10),
                              Text(
                                "Cari Mobil...",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ===================== CATEGORY CHIPS =====================
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _chip("SUV", selected: true),
                            const SizedBox(width: 8),
                            _chip("MPV"),
                            const SizedBox(width: 8),
                            _chip("Sedan"),
                            const SizedBox(width: 8),
                            _chip("Hatchback"),
                            const SizedBox(width: 8),
                            _chip("Luxury"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Mobil Tersedia",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),

            // ===================== GRID MOBIL =====================
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: mockCars.length,
                    itemBuilder: (context, index) {
                      final car = mockCars[index];
                      return _carCard(context, car);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // ===================== NAVIGATION BAR =====================
      bottomNavigationBar: _bottomNav(context),

    );
  }

  // ====================================================
  // WIDGET PEMBANTU
  // ====================================================

  Widget _chip(String label, {bool selected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? AppColors.primary : Colors.grey.shade300,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.textWhite : Colors.grey.shade700,
          fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _carCard(BuildContext context, CarModel car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CarDetailPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(14)),
                    child: Image.network(
                      car.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, err, st) {
                        return Container(
                          color: AppColors.background,
                          alignment: Alignment.center,
                          child: Text(
                            car.name,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        );
                      },
                    ),
                  ),

                  if (car.isBooked)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Lihat Detail",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    car.specs,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp ${car.pricePerDay} / hari",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _bottomNav(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _navItem(
          context,
          Icons.home,
          "Beranda",
          onTap: () {
            // Tetap di Dashboard
          },
          selected: true,
        ),

        _navItem(
          context,
          Icons.search,
          "Pencarian",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CarSearchPage()),
            );
          },
        ),

        _navItem(
          context,
          Icons.access_time,
          "Riwayat",
          onTap: () {
            // Nanti bisa diarahkan ke halaman riwayat
          },
        ),

        _navItem(
          context,
          Icons.person_outline,
          "Akun Saya",
          onTap: () {
            // Nanti bisa diarahkan ke halaman profil pengguna
          },
        ),
      ],
    ),
  );
}


Widget _navItem(
  BuildContext context,
  IconData icon,
  String label, {
  bool selected = false,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: selected ? AppColors.primary : Colors.grey.shade500,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : Colors.grey.shade500,
            fontSize: 11,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

}
