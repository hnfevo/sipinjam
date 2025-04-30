import 'package:flutter/material.dart';
import '../models/equipment.dart';
import '../../../widgets/booking_form.dart';
import '../../../core/constants.dart';
import '../../shared/screens/booking_process_screen.dart';
import '../../../services/equipment_service.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({Key? key}) : super(key: key);

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  final EquipmentService _equipmentService = EquipmentService();
  List<Equipment> _equipments = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadEquipments();
  }

  void _loadEquipments() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final equipments = await _equipmentService.getEquipments();
      setState(() {
        _equipments = equipments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  List<Equipment> get _filteredEquipments {
    if (_searchQuery.isEmpty) return _equipments;
    return _equipments
        .where((equipment) =>
            equipment.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text(
          'Daftar Alat',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadEquipments, // Refresh data
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Text(
                    'No',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Nama Barang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Tersedia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Aksi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredEquipments.isEmpty
                    ? const Center(child: Text('Tidak ada data'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _filteredEquipments.length,
                          itemBuilder: (context, index) {
                            final equipment = _filteredEquipments[index];
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text((index + 1).toString()),
                                ),
                                Expanded(flex: 3, child: Text(equipment.name)),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    equipment.availableQuantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.play_circle,
                                        color: Colors.green,
                                      ),
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingForm(
                                            title: 'Form Peminjaman Alat',
                                            isEquipment: true,
                                            maxQuantity:
                                                equipment.availableQuantity,
                                            onSubmit:
                                                (startDate, endDate, reason, quantity) async {
                                              try {
                                                final response = await _equipmentService
                                                    .createLoan(
                                                  equipmentId: equipment.id,
                                                  quantity: quantity!,
                                                  purpose: reason,
                                                  loanDate: startDate,
                                                  returnDate: endDate,
                                                );
                                                if (response['status'] == true) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const BookingProcessScreen(),
                                                    ),
                                                  );
                                                }
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content:
                                                          Text(e.toString())),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}