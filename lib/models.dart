// lib/models.dart
import 'package:flutter/material.dart';

/// Model untuk merepresentasikan sebuah Lagu.
class SongModel {
  final String title;
  final String artist;
  final String assetFileName; 
  final Duration duration;
  
  const SongModel({
    required this.title,
    required this.artist,
    required this.assetFileName,
    required this.duration,
  });
}

/// Model untuk merepresentasikan Kategori Musik.
class MusicCategoryModel {
  final String name;
  final IconData icon;
  final Color color;

  const MusicCategoryModel({required this.name, required this.icon, required this.color});
}
