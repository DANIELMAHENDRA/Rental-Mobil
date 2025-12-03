import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F0F5), // Warna latar belakang lembut

      body: Column(
        children: [
          // ==================== CUSTOM TOP BAR ====================
          Container(
            padding: const EdgeInsets.only(top: 40, left: 0, right: 0),
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF4F7D95),
            ),
            child: Row(
              children: [
                // Tombol Back
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 20),

                const Expanded(
                  child: Text(
                    "Pembayaran",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 40), // Penyeimbang supaya teks tetap center
              ],
            ),
          ),

          const SizedBox(height: 80),

          // ==================== ICON SUCCESS ====================
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 80,
                color: Colors.orange.shade600,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ==================== TEXT ====================
          const Text(
            "Pembayaran Berhasil",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}
