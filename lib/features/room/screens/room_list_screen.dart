import 'package:flutter/material.dart';
import '../models/room.dart';
import '../../../widgets/booking_form.dart';
import '../../../core/constants.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({Key? key}) : super(key: key);

  // Simulasi data dari backend
  final List<Room> rooms = const [
    Room(id: 1, name: 'IOT 101'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text('Daftar Ruangan', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(flex: 1, child: Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Nama Ruangan', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
            ),
            const Divider(),
            ...rooms.map((room) => Row(
                  children: [
                    Expanded(flex: 1, child: Text(room.id.toString())),
                    Expanded(flex: 3, child: Text(room.name)),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle, color: Colors.green),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingForm(
                                title: 'Form Peminjaman Ruangan',
                                onSubmit: (startDate, endDate, reason) {
                                  // Simulasi pengiriman ke backend
                                  print('Peminjaman Ruangan: $startDate - $endDate, Alasan: $reason');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}