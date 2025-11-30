import 'package:flutter/material.dart';

// --- 1. Model Data Kategori Musik ---
class MusicCategory {
  final String name;
  final IconData icon;
  final Color color;

  const MusicCategory({required this.name, required this.icon, required this.color});
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
  // Daftar Kategori Musik (hanya 4 item)
  final List<MusicCategory> _categories = const [
    MusicCategory(name: "Pop", icon: Icons.album, color: Colors.blue),
    MusicCategory(name: "Rock", icon: Icons.album, color: Colors.red), 
    MusicCategory(name: "Jazz", icon: Icons.audiotrack, color: Colors.purple),
    MusicCategory(name: "Klasik", icon: Icons.piano, color: Colors.green),
  ];

  late final List<MusicCategory> _initialCategories = _categories;

  @override
  Widget build(BuildContext context) {
    // Memberi warna latar belakang putih polos
    return Scaffold(
      backgroundColor: Colors.white, 
      body: CustomScrollView(
        slivers: [
          // --- 2. HEADER KUSTOM (SLIVER APP BAR) ---
          // Catatan: SliverAppBar sekarang kosong dan hanya berfungsi sebagai padding di atas.
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, 
            pinned: false, 
            toolbarHeight: 0, // Dibuat 0 untuk menghilangkan ruang yang tidak perlu
            title: const SizedBox.shrink(), // Dikosongkan
          ),
          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 30), // Menambahkan ruang di atas search bar

                // --- 3. SEARCH BAR SAJA (Tombol Filter Dihapus) ---
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
                      // Tombol Filter (Container 50x50) TELAH DIHAPUS dari sini.
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // --- 4. JUDUL KATEGORI ---
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
          
          // --- 5. DAFTAR KATEGORI (GRID VIEW) ---
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
                return CategoryCard(category: category);
              },
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 30),
                
                // --- 6. Bagian Daftar Putar Populer ---
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


// Catatan: CategoryCard dan CategorySongsPage tidak berubah, 
// tetapi harus ada di file Anda agar kode di atas berfungsi.

// Widget untuk setiap kartu kategori (CategoryCard)
class CategoryCard extends StatelessWidget {
  final MusicCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Asumsi CategorySongsPage sudah didefinisikan di tempat lain
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySongsPage(category: category),
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

// Halaman Tujuan Navigasi (CategorySongsPage)
class CategorySongsPage extends StatelessWidget {
  final MusicCategory category;

  const CategorySongsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lagu ${category.name}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: category.color,
        foregroundColor: Colors.white, 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 80, color: category.color.withOpacity(0.7)),
            const SizedBox(height: 20),
            Text(
              "Daftar Lagu Kategori ${category.name}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Di sini akan tampil daftar lagu Populer, Terbaru, dll.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
