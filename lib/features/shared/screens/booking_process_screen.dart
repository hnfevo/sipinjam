import 'package:flutter/material.dart';
import '../../home/screens/home_screen.dart';

class BookingProcessScreen extends StatelessWidget {
  const BookingProcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sedang di proses....', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Image.asset('assets/person_illustration.png', height: 150, errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 80)),
              const SizedBox(height: 20),
              const Text(
                '“Permintaan peminjaman kamu saat ini sedang dalam proses verifikasi oleh sistem.\n\nUntuk mengetahui perkembangan atau status terbaru dari peminjaman tersebut, silakan cek secara berkala melalui menu Riwayat Peminjaman yang tersedia di halaman akun kamu.”',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300, foregroundColor: Colors.black),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}