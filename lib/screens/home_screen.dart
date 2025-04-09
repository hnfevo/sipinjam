import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE32929),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          'SI PINJAM TEL-U',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Column(
                children: [
                  Text("Janjang Purwoko Aji", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("2211102019", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            _buildDrawerItem(Icons.home, "Beranda", () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.meeting_room, "Peminjaman Ruangan", () {}),
            _buildDrawerItem(Icons.devices_other, "Peminjaman Alat", () {}),
            _buildDrawerItem(Icons.history, "Riwayat", () {}),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika logout di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE32929),
                  ),
                  child: const Text("Logout"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildContentCard(),
        ],
      ),
    );
  }

  Widget _buildContentCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPersonIllustration(),
            const SizedBox(height: 16),
            _buildTitle(),
            const SizedBox(height: 12),
            _buildDescription(),
            const SizedBox(height: 16),
            _buildFeaturesSection(),
            const SizedBox(height: 16),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonIllustration() {
    return Image.asset(
      'assets/person_illustration.png',
      height: 150,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 150,
          width: 200,
          color: Colors.grey.shade200,
          child: const Icon(Icons.person, size: 80),
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Text(
      'SI PINJAM TEL-U',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE32929),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return const Text(
      'adalah platform peminjaman sarana dan prasarana berbasis web yang dirancang untuk mempermudah mahasiswa dan dosen dalam mengakses fasilitas kampus. Dengan sistem yang efisien dan transparan, pengguna dapat dengan mudah mengajukan peminjaman, memantau status permohonan, serta menerima notifikasi real-time terkait persetujuan atau penolakan.',
      style: TextStyle(fontSize: 12, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildFeaturesSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fitur Utama:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 8),
        _FeatureItem('Peminjaman Ruangan - Pilih ruangan yang tersedia, tentukan tanggal peminjaman, dan ajukan permohonan dengan cepat.'),
        _FeatureItem('Peminjaman Alat - Cek ketersediaan alat, pilih jumlah yang dibutuhkan, dan ajukan peminjaman secara langsung.'),
        _FeatureItem('Riwayat Peminjaman - Pantau daftar peminjaman yang telah dilakukan beserta statusnya.'),
        _FeatureItem('Notifikasi Real-Time - Dapatkan update langsung mengenai status peminjaman melalui notifikasi.'),
        _FeatureItem('Antarmuka Intuitif - Desain ramah pengguna yang mempermudah navigasi dan proses peminjaman.'),
      ],
    );
  }

  Widget _buildFooter() {
    return const Text(
      'SI-PINJAM hadir untuk meningkatkan efisiensi dan kenyamanan dalam pengelolaan sarana dan prasarana di Telkom University 🎓',
      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
