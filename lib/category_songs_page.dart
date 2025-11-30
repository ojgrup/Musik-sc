// lib/category_songs_page.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'models.dart';

// Fungsi utilitas untuk memformat durasi
String _formatDuration(Duration d) {
  final minutes = d.inMinutes;
  final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
  return "$minutes:$seconds";
}

/// Halaman yang menampilkan daftar lagu berdasarkan kategori.
class CategorySongsPage extends StatefulWidget {
  final MusicCategoryModel category;
  final List<SongModel> songs;

  const CategorySongsPage({super.key, required this.category, required this.songs});

  @override
  State<CategorySongsPage> createState() => _CategorySongsPageState();
}

class _CategorySongsPageState extends State<CategorySongsPage> {
  
  final _audioPlayer = AudioPlayer();
  
  Future<void> _playSong(SongModel song) async {
    // Membuat path aset yang lengkap: 'assets/music/NAMA_KATEGORI/NAMA_FILE.mp3'
    final assetPath = 'assets/music/${widget.category.name}/${song.assetFileName}';
    
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(assetPath);
      _audioPlayer.play();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Memutar: ${song.title}"))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("GAGAL MEMUTAR. Path: $assetPath. Error: $e"), duration: const Duration(seconds: 4),)
      );
    }
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: widget.category.color,
        foregroundColor: Colors.white, 
      ),
      body: widget.songs.isEmpty
          ? Center(child: Text("Tidak ada lagu dalam kategori ${widget.category.name}."))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: widget.songs.length,
              itemBuilder: (context, index) {
                final song = widget.songs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: widget.category.color.withOpacity(0.3),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: widget.category.color),
                    ), 
                  ),
                  title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(song.artist),
                  trailing: Text(
                    _formatDuration(song.duration),
                  ),
                  onTap: () {
                    _playSong(song);
                  },
                );
              },
            ),
    );
  }
}
