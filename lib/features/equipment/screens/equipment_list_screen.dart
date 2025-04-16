import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../../../widgets/booking_form.dart';
import '../../../core/constants.dart';

class EquipmentListScreen extends StatelessWidget {
  const EquipmentListScreen({Key? key}) : super(key: key);

  // Simulasi data dari backend
  final List<Equipment> equipments = const [
    Equipment(id: 1, name: 'Kamera (Canon 600D)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text('Daftar Alat', style: TextStyle(color: Colors.white)),
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
                Expanded(flex: 3, child: Text('Nama Alat', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
            ),
            const Divider(),
            ...equipments.map((equipment) => Row(
                  children: [
                    Expanded(flex: 1, child: Text(equipment.id.toString())),
                    Expanded(flex: 3, child: Text(equipment.name)),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle, color: Colors.green),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingForm(
                                title: 'Form Peminjaman Alat',
                                onSubmit: (startDate, endDate, reason) {
                                  // Simulasi pengiriman ke backend
                                  print('Peminjaman Alat: $startDate - $endDate, Alasan: $reason');
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