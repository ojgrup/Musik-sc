// lib/dashboard_page.dart
import 'package:flutter/material.dart';
import 'models.dart'; 
import 'category_songs_page.dart'; 

// <<< IMPORT SEMUA FILE DATA LAGU >>>
import 'data/original_songs.dart';
import 'data/cover_songs.dart';
import 'data/akustik_songs.dart';
import 'data/karaoke_songs.dart';

// ------------------------------------------------------------------
// WIDGET KARTU KATEGORI
// ------------------------------------------------------------------

/// Widget yang menampilkan kartu kategori dan menangani navigasi.
class CategoryCardWidget extends StatelessWidget {
  final MusicCategoryModel category;
  final List<SongModel> songs; 
  
  const CategoryCardWidget({super.key, required this.category, required this.songs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySongsPage(
              category: category,
              songs: songs, 
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: category.color.withOpacity(0.3), width: 1.5),
        ),
        child: Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 30, color: category.color),
            const SizedBox(width: 8),
            Expanded( 
              child: Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: category.color,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// DASHBOARD PAGE (Tampilan Utama)
// ------------------------------------------------------------------

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
  final List<MusicCategoryModel> _categories = const [
    MusicCategoryModel(name: "Original", icon: Icons.music_note, color: Colors.blue),
    MusicCategoryModel(name: "Cover", icon: Icons.mic_external_on, color: Colors.red), 
    MusicCategoryModel(name: "Akustik", icon: Icons.queue_music, color: Colors.purple),
    MusicCategoryModel(name: "Karaoke", icon: Icons.album, color: Colors.green),
  ];

  late final List<MusicCategoryModel> _initialCategories = _categories;

  // Data Lagu Sekarang DIKUMPULKAN dari file eksternal (data/*.dart)
  late final Map<String, List<SongModel>> _songsByCategories = {
    "Original": originalSongs,
    "Cover": coverSongs,
    "Akustik": akustikSongs,
    "Karaoke": karaokeSongs,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: CustomScrollView(
        slivers: [
          // SliverAppBar KOSONG
          const SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, 
            pinned: false, 
            toolbarHeight: 0, 
            title: SizedBox.shrink(),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 30), 

                // SEARCH BAR SAJA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50, 
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300, width: 1),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              hintText: "Search For Any Music", 
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.search, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // JUDUL KATEGORI
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                  child: Text(
                    "Jelajahi Kategori Musik",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          
          // DAFTAR KATEGORI (GRID VIEW 2x2)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                crossAxisSpacing: 16, 
                mainAxisSpacing: 16, 
                childAspectRatio: 2.0, 
              ),
              itemCount: _initialCategories.length, 
              itemBuilder: (context, index) {
                final category = _initialCategories[index];
                final List<SongModel> songs = _songsByCategories[category.name] ?? []; 

                return CategoryCardWidget(
                  category: category, 
                  songs: songs, 
                );
              },
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 30),
                
                // Bagian Daftar Putar Populer
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                  child: Text(
                    "Daftar Putar Populer",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      "Tempat List Lagu/Playlist akan muncul di sini.",
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  } 
}
