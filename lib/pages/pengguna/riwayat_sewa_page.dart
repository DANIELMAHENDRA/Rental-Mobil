import 'package:flutter/material.dart';

class RiwayatSewaPage extends StatefulWidget {
  const RiwayatSewaPage({super.key});

  @override
  State<RiwayatSewaPage> createState() => _RiwayatSewaPageState();
}

class _RiwayatSewaPageState extends State<RiwayatSewaPage> {
  String selectedFilter = "Semua";

  // --------- SAMPLE DATA -------------
  final List<Map<String, dynamic>> historyData = [
    {
      "booking": "#1234",
      "tanggal": "09 Oktober 2025",
      "mobil": "Honda CRV",
      "rent": "10 Okt 2025 - 15 Okt 2025",
      "harga": "Rp 3.500.000",
      "status": "Selesai",
    },
    {
      "booking": "#1234",
      "tanggal": "09 Oktober 2025",
      "mobil": "Honda CRV",
      "rent": "10 Okt 2025 - 15 Okt 2025",
      "harga": "Rp 3.500.000",
      "status": "Dibatalkan",
    },
    {
      "booking": "#1234",
      "tanggal": "09 Oktober 2025",
      "mobil": "Honda CRV",
      "rent": "10 Okt 2025 - 15 Okt 2025",
      "harga": "Rp 3.500.000",
      "status": "Aktif",
    },
  ];

  // Warna status
  Color statusColor(String status) {
    switch (status) {
      case "Selesai":
        return Colors.green;
      case "Dibatalkan":
        return Colors.red;
      case "Aktif":
        return Colors.teal;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0EDF4),
      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 40, bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF4E7C96),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Riwayat Pemesanan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ============ FILTER TAB ================
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              filterButton("Semua"),
              const SizedBox(width: 10),
              filterButton("Selesai"),
              const SizedBox(width: 10),
              filterButton("Dibatalkan"),
              const SizedBox(width: 10),
              filterButton("Aktif"),
            ],
          ),

          const SizedBox(height: 20),

          // ============ LIST RIWAYAT =============
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                var item = historyData[index];

                // Filter berdasarkan tab
                if (selectedFilter != "Semua" &&
                    item["status"] != selectedFilter) {
                  return const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Booking + Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Booking ${item["booking"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              item["status"],
                              style: TextStyle(
                                color: statusColor(item["status"]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Text(item["tanggal"]),

                        const SizedBox(height: 12),

                        Text(
                          item["mobil"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(item["rent"], style: const TextStyle(fontSize: 14)),

                        const SizedBox(height: 14),

                        Text(
                          item["harga"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF4E7C96)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Lihat Detail"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============ FILTER BUTTON WIDGET ============
  Widget filterButton(String label) {
    bool isActive = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF4E7C96) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
