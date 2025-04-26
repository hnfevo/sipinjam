import 'package:flutter/material.dart';

class BookingForm extends StatefulWidget {
  final String title;
  final bool isEquipment; // Tambahkan parameter untuk membedakan form
  final int? maxQuantity; // Tambahkan parameter untuk batas maksimal jumlah
  final Function(DateTime, DateTime, String, int?) onSubmit; // Ubah onSubmit untuk menerima quantity

  const BookingForm({
    Key? key,
    required this.title,
    required this.onSubmit,
    this.isEquipment = false, // Default false (untuk ruangan)
    this.maxQuantity, // Opsional, hanya digunakan untuk peminjaman alat
  }) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController(); // Controller untuk jumlah barang
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _handleSubmit() async {
    if (_reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alasan peminjaman harus diisi')),
      );
      return;
    }

    if (widget.isEquipment) {
      if (_quantityController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah barang harus diisi')),
        );
        return;
      }
      final quantity = int.tryParse(_quantityController.text);
      if (quantity == null || quantity <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah barang harus berupa angka positif')),
        );
        return;
      }
      if (widget.maxQuantity != null && quantity > widget.maxQuantity!) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Jumlah barang tidak boleh lebih dari ${widget.maxQuantity}')),
        );
        return;
      }
    }

    // Gabungkan tanggal dan waktu untuk startDateTime dan endDateTime
    final startDateTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute,
    );
    final endDateTime = DateTime(
      _endDate.year,
      _endDate.month,
      _endDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal pengembalian harus setelah tanggal peminjaman')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final quantity = widget.isEquipment ? int.parse(_quantityController.text) : null;
      await widget.onSubmit(startDateTime, endDateTime, _reasonController.text, quantity);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tanggal Peminjaman',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, true),
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  child: const Text('Pilih Waktu'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Tanggal Pengembalian',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context, false),
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context, false),
                  child: const Text('Pilih Waktu'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tambahkan field Jumlah Barang hanya untuk peminjaman alat
            if (widget.isEquipment) ...[
              const Text(
                'Jumlah Barang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Masukkan jumlah barang (maks ${widget.maxQuantity})',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'Alasan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan alasan peminjaman',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text('Ajukan Peminjaman'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}