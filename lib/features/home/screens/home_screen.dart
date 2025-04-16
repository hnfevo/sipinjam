import 'package:flutter/material.dart';
import '../../auth/screens/login_screen.dart';
import '../../equipment/screens/equipment_list_screen.dart';
import '../../room/screens/room_list_screen.dart';
import '../../../core/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text(AppStrings.appName, style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(radius: 40, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 50, color: Colors.white)),
              const SizedBox(height: 10),
              const Text("Janjang Purwoko Aji", style: TextStyle(fontWeight: FontWeight.bold)),
              const Text("2211102019", style: TextStyle(color: AppColors.primaryRed)),
              const SizedBox(height: 30),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold))),
              ListTile(leading: const Icon(Icons.home, color: AppColors.primaryRed), title: const Text("Beranda"), onTap: () => Navigator.pop(context)),
              ListTile(
                leading: const Icon(Icons.meeting_room, color: AppColors.primaryRed),
                title: const Text("Peminjaman Ruangan"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomListScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.devices_other, color: AppColors.primaryRed),
                title: const Text("Peminjaman Alat"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EquipmentListScreen())),
              ),
              ListTile(leading: const Icon(Icons.history, color: AppColors.primaryRed), title: const Text("Riwayat"), onTap: () => Navigator.pop(context)),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                    child: const Text("Logout"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            children: [
              Image.asset('assets/person_illustration.png', height: 150, errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 80)),
              const SizedBox(height: 16),
              const Text(AppStrings.appName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryRed), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text(
                'adalah platform peminjaman sarana dan prasarana berbasis web yang dirancang untuk mempermudah mahasiswa dan dosen dalam mengakses fasilitas kampus. Dengan sistem yang efisien dan transparan, pengguna dapat dengan mudah mengajukan peminjaman, memantau status permohonan, serta menerima notifikasi real-time terkait persetujuan atau penolakan.',
                style: TextStyle(fontSize: 12, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fitur Utama:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  _FeatureItem('Peminjaman Ruangan - Pilih ruangan yang tersedia, tentukan tanggal peminjaman, dan ajukan permohonan dengan cepat.'),
                  _FeatureItem('Peminjaman Alat - Cek ketersediaan alat, pilih jumlah yang dibutuhkan, dan ajukan peminjaman secara langsung.'),
                  _FeatureItem('Riwayat Peminjaman - Pantau daftar peminjaman yang telah dilakukan beserta statusnya.'),
                  _FeatureItem('Notifikasi Real-Time - Dapatkan update langsung mengenai status peminjaman melalui notifikasi.'),
                  _FeatureItem('Antarmuka Intuitif - Desain ramah pengguna yang mempermudah navigasi dan proses peminjaman.'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'SI-PINJAM hadir untuk meningkatkan efisiensi dan kenyamanan dalam pengelolaan sarana dan prasarana di Telkom University 🎓',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
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
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}