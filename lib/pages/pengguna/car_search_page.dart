import 'package:flutter/material.dart';

class CarItem {
  final String name;
  final String seats;
  final String price;
  final String image;
  final bool available;

  CarItem({
    required this.name,
    required this.seats,
    required this.price,
    required this.image,
    required this.available,
  });
}

// ==== MOCK DATA ====
List<CarItem> carList = [
  CarItem(
    name: "Toyota Avanza",
    seats: "5 Kursi",
    price: "350.000",
    available: true,
    image:
        "https://placehold.co/400x300/FF3333/FFFFFF?text=Avanza",
  ),
  CarItem(
    name: "Honda BR-V",
    seats: "5 Kursi",
    price: "350.000",
    available: true,
    image:
        "https://placehold.co/400x300/444444/FFFFFF?text=BR-V",
  ),
  CarItem(
    name: "Toyota Agya",
    seats: "5 Kursi",
    price: "300.000",
    available: true,
    image:
        "https://placehold.co/400x300/BBBBBB/000000?text=Agya",
  ),
];

class CarSearchPage extends StatefulWidget {
  const CarSearchPage({super.key});

  @override
  State<CarSearchPage> createState() => _CarSearchPageState();
}

class _CarSearchPageState extends State<CarSearchPage> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan pencarian
    List<CarItem> filteredCars = carList
        .where((car) =>
            car.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
// ==================== SEARCH BAR WITH BLUE BACKGROUND ====================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E7C96), // Warna biru seperti gambar
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Cari nama mobil...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 16),

              // ==================== LABEL FILTER ====================
              const Text(
                "Filter",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(height: 10),

              // ==================== FILTER BUTTONS ====================
              Row(
                children: [
                  _filterChip("Merk"),
                  const SizedBox(width: 8),
                  _filterChip("Tipe"),
                  const SizedBox(width: 8),
                  _filterChip("Harga"),
                  const SizedBox(width: 8),
                  _filterChip("Tanggal", icon: Icons.calendar_month),
                ],
              ),

              const SizedBox(height: 16),

              // ==================== LIST MOBIL ====================
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = filteredCars[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          // Gambar mobil
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              car.image,
                              width: 90,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 90,
                                  height: 70,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.broken_image, size: 30),
                                );
                              },
                            ),

                          ),

                          const SizedBox(width: 12),

                          // Detail
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  car.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(car.seats),
                                const SizedBox(height: 6),
                                Text(
                                  "Rp ${car.price} /hari",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.green,
                                      size: 10,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Tersedia",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget chip filter
  Widget _filterChip(String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 16),
          if (icon != null) const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
