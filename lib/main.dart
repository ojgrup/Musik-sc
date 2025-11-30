import 'package:flutter/material.dart';
// Import 'dashboard.dart' dari project lokal Anda
import 'package:app_dasar/dashboard.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pemutar Musik Dasar', // Tambahkan judul aplikasi
      debugShowCheckedModeBanner: false,
      theme: ThemeData( // Tambahkan tema dasar
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
