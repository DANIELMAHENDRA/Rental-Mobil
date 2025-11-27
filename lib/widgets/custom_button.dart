import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // ✅ Bisa null
  final bool isLoading; // ✅ Tambahan untuk loading spinner

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // bisa null sekarang
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed != null ? AppColors.primary : Colors.grey, // nonaktif = abu-abu
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(text),
    );
  }
}
