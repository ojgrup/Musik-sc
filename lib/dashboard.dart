import 'package:flutter/material.dart';

// ------------------------------------------------------------------
// --- MODEL DATA ---
// ------------------------------------------------------------------

// Model Data Lagu
class Song {
  final String title;
  final String artist;
  final String albumArtUrl;
  final Duration duration;
  
  const Song({
    required this.title,
    required this.artist,
    required this.albumArtUrl,
    required this.duration,
  });
}

// Model Data Kategori Musik
class MusicCategory {
  final String name;
  final IconData icon;
  final Color color;

  const MusicCategory({required this.name, required this.icon, required this.color});
}


// ------------------------------------------------------------------
// --- DASHBOARD PAGE ---
// ------------------------------------------------------------------

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
  // Daftar Kategori Musik (dibuat sesuai dengan folder assets Anda)
  final List<MusicCategory> _categories = const [
    MusicCategory(name: "Original", icon: Icons.music_note, color: Colors.blue),
    MusicCategory(name: "Cover", icon: Icons.mic_external_on, color: Colors.red), 
    MusicCategory(name: "Akustik", icon: Icons.queue_music, color: Colors.purple),
    MusicCategory(name: "Karaoke", icon: Icons.album, color: Colors.green),
  ];

  late final List<MusicCategory> _initialCategories = _categories;

  // Data Lagu Sampel berdasarkan Kategori
  final Map<String, List<Song>> _songsByCategories = const {
    "Original": [
      Song(title: "Lagu A (Original)", artist: "Artis X", albumArtUrl: "assets/covers/original_1.jpg", duration: Duration(minutes: 4, seconds: 15)),
      Song(title: "Lagu B (Original)", artist: "Artis Y", albumArtUrl: "assets/covers/original_2.jpg", duration: Duration(minutes: 3, seconds: 30)),
    ],
    "Cover": [
      Song(title: "Lagu A (Cover)", artist: "Cover Artis 1", albumArtUrl: "assets/covers/cover_1.jpg", duration: Duration(minutes: 4, seconds: 10)),
      Song(title: "Lagu C (Cover)", artist: "Cover Artis 2", albumArtUrl: "assets/covers/cover_2.jpg", duration: Duration(minutes: 3, seconds: 50)),
    ],
    "Akustik": [
      Song(title: "Lagu Z (Akustik)", artist: "Artis Z", albumArtUrl: "assets/covers/akustik_1.jpg", duration: Duration(minutes: 5, seconds: 20)),
    ],
    "Karaoke": [
      Song(title: "Lagu K (Karaoke)", artist: "Instrumental", albumArtUrl: "assets/covers/karaoke_1.jpg", duration: Duration(minutes: 4, seconds: 05)),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: CustomScrollView(
        slivers: [
          // HEADER KUSTOM (Header dan Notifikasi Dihapus)
          const SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, 
            pinned: false, 
            toolbarHeight: 0, // Dibuat 0 agar tidak memakan tempat
            title: SizedBox.shrink(),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 30), // Spasi di atas Search Bar

                // SEARCH BAR SAJA (Filter Dihapus)
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
                final List<Song> songs = _songsByCategories[category.name] ?? []; 

                return CategoryCard(
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


// ------------------------------------------------------------------
// --- WIDGET CATEGORY CARD (MENGANDUNG NAVIGASI) ---
// ------------------------------------------------------------------
class CategoryCard extends StatelessWidget {
  final MusicCategory category;
  final List<Song> songs; 
  
  const CategoryCard({super.key, required this.category, required this.songs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigasi, mengirimkan kategori dan daftar lagu yang sesuai
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
// --- HALAMAN TUJUAN NAVIGASI (CATEGORYSONGSPAGE) ---
// ------------------------------------------------------------------
class CategorySongsPage extends StatelessWidget {
  final MusicCategory category;
  final List<Song> songs;

  const CategorySongsPage({super.key, required this.category, required this.songs});

  // Fungsi utilitas untuk memformat durasi (misalnya: 03:20)
  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: category.color,
        foregroundColor: Colors.white, 
      ),
      body: songs.isEmpty
          ? Center(child: Text("Tidak ada lagu dalam kategori ${category.name}."))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: category.color.withOpacity(0.3),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: category.color),
                    ), 
                  ),
                  title: Text(song.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(song.artist),
                  trailing: Text(
                    _formatDuration(song.duration),
                  ),
                  onTap: () {
                    // Logika memutar lagu
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Memutar ${song.title}"))
                    );
                  },
                );
              },
            ),
    );
  }
}
