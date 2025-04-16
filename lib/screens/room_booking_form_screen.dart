import 'package:flutter/material.dart';
import 'booking_process_screen.dart'; // Import halaman proses

class RoomBookingFormScreen extends StatelessWidget {
  const RoomBookingFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE32929),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Form Peminjaman Ruangan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tanggal Peminjaman
            Row(
              children: [
                const Text(
                  'Tanggal Peminjaman',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('DD/MM/YYYY'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tanggal Pengembalian
            Row(
              children: [
                const Text(
                  'Tanggal Pengembalian',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('DD/MM/YYYY'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Alasan Peminjaman
            const Text(
              'Alasan Peminjaman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const Spacer(),
            // Tombol Ajukan Peminjaman
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman proses
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookingProcessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text('Ajukan Peminjaman'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}