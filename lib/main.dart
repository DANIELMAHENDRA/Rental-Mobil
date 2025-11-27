import 'package:flutter/material.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/pengguna/detail_mobil_page.dart';
import 'pages/pengguna/dashboard_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Rental Mobil',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/car-detail': (context) => const CarDetailPage(),
      
      
      },
    );
  }
}
