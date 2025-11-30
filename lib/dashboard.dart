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
  
  // Perbaikan: Daftar Kategori Musik sekarang hanya berisi 4 item
  final List<MusicCategory> _categories = const [
    MusicCategory(name: "Pop", icon: Icons.album, color: Colors.blue),
    MusicCategory(name: "Rock", icon: Icons.album, color: Colors.red), 
    MusicCategory(name: "Jazz", icon: Icons.audiotrack, color: Colors.purple),
    MusicCategory(name: "Klasik", icon: Icons.piano, color: Colors.green),
  ];

  // Karena daftar sudah 4, kita bisa menggunakan _categories langsung
  // atau membuat alias jika diperlukan di masa depan.
  late final List<MusicCategory> _initialCategories = _categories;

  @override
  Widget build(BuildContext context) {
    // Memberi warna latar belakang putih polos
    return Scaffold(
      backgroundColor: Colors.white, 
      body: CustomScrollView(
        slivers: [
          // --- 2. HEADER KUSTOM (SLIVER APP BAR) ---
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, 
            pinned: false, 
            toolbarHeight: 80, 
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon Profil
                    const Icon(Icons.account_circle, size: 40, color: Colors.black87),
                    const SizedBox(width: 12),
                    // Teks "Hallo" dan Nama
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hallo ✨", 
                          style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal)
                        ),
                        Text(
                          "Dennis Dwi Musti", 
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87
                          )
                        ),
                      ],
                    ),
                  ],
                ),
                // Icon Notifikasi
                const Icon(Icons.notifications, size: 30, color: Colors.black87),
              ],
            ),
          ),
          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),

                // --- 3. SEARCH BAR DAN FILTER ---
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
                      const SizedBox(width: 10),
                      // Tombol Filter
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black, 
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.filter_list, 
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
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
          // Menggantikan ListView horizontal dengan SliverGrid agar tampil 2 kolom
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              // Menentukan tata letak grid: 2 kolom
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 item per baris
                crossAxisSpacing: 16, // Jarak horizontal
                mainAxisSpacing: 16, // Jarak vertikal
                childAspectRatio: 2.0, // Rasio lebar/tinggi kartu
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
                
                // --- 6. Bagian Daftar Putar Populer (Contoh Placeholder) ---
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 10.0),
                  child: Text(
                    "Daftar Putar Populer",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                
                // Tempat di mana daftar lagu/playlist akan ditampilkan
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


// Widget untuk setiap kartu kategori
class CategoryCard extends StatelessWidget {
  final MusicCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anda memilih kategori: ${category.name}. Akan menuju ke daftar lagu!'))
        );
      },
      child: Container(
        // width dihapus karena ukuran diatur oleh SliverGrid
        decoration: BoxDecoration(
          color: category.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: category.color.withOpacity(0.3), width: 1.5),
        ),
        child: Row( // Menggunakan Row untuk tampilan Icon dan Text berdampingan
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, size: 30, color: category.color),
            const SizedBox(width: 8),
            Expanded( // Expanded untuk memastikan teks tidak meluap
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
