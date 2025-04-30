import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../../../core/constants.dart';
import '../../../services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final HistoryService _historyService = HistoryService();
  String _searchQuery = '';
  List<Booking> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadBookings();
  }

  void _loadBookings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final roomBookings = await _historyService.getBookings();
      final equipmentLoans = await _historyService.getEquipmentLoans();
      setState(() {
        _bookings = [...roomBookings, ...equipmentLoans];
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

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Booking> _filterBookings(String status) {
    return _bookings
        .where((booking) {
          final normalizedStatus = booking.status == 'pending'
              ? 'Proses Pengajuan'
              : booking.status == 'approved'
                  ? 'Proses Peminjaman'
                  : 'Selesai';
          return normalizedStatus == status &&
              (booking.userName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  booking.itemName.toLowerCase().contains(_searchQuery.toLowerCase()));
        })
        .toList();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _handleCancel(int bookingId, String itemType) async {
    // Tampilkan dialog konfirmasi
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Pembatalan'),
        content: Text('Apakah Anda yakin ingin membatalkan peminjaman $itemType ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final response = await _historyService.cancelLoan(bookingId);
      if (response['status'] == true) {
        _loadBookings(); // Refresh data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Peminjaman telah dibatalkan')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryRed,
        title: const Text(
          'Riwayat Peminjaman',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Proses Pengajuan'),
            Tab(text: 'Proses Peminjaman'),
            Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildBookingList('Proses Pengajuan'),
                        _buildBookingList('Proses Peminjaman'),
                        _buildBookingList('Selesai'),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList(String status) {
    final filteredBookings = _filterBookings(status);
    if (filteredBookings.isEmpty) {
      return const Center(child: Text('Tidak ada data'));
    }
    return ListView.builder(
      itemCount: filteredBookings.length,
      itemBuilder: (context, index) {
        final booking = filteredBookings[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Peminjam: ${booking.userName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('${booking.itemType}: ${booking.itemName}'),
                if (booking.quantity != null)
                  Text('Jumlah: ${booking.quantity}'),
                Text(
                  'Tanggal Peminjaman: ${booking.startDate.day}/${booking.startDate.month}/${booking.startDate.year}',
                ),
                Text(
                  'Tanggal Pengembalian: ${booking.endDate.day}/${booking.endDate.month}/${booking.endDate.year}',
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      booking.itemType,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    if (status == 'Proses Peminjaman') ...[
                      ElevatedButton(
                        onPressed: () => _handleCancel(
                          booking.id,
                          booking.itemType,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Batalkan'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}