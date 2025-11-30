// lib/main.dart

import 'package:flutter/material.dart';
// PASTIKAN NAMA PACKAGE ANDA ('app_dasar') SUDAH BENAR
import 'package:app_dasar/dashboard.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pemutar Musik Dasar', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // Memastikan memanggil widget utama dari dashboard.dart
      home: const DashboardPage(), 
    );
  }
}
