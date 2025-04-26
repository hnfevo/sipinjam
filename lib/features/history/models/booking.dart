class Booking {
  final int id;
  final int userId;
  final String userName;
  final String itemType; // "Alat" atau "Ruangan"
  final String itemName;
  final int? quantity; // Hanya untuk peminjaman alat
  final String purpose;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.userName,
    required this.itemType,
    required this.itemName,
    this.quantity,
    required this.purpose,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'] ?? 'Unknown',
      itemType: json['item_type'] ?? 'Unknown',
      itemName: json['item_name'] ?? 'Unknown',
      quantity: json['quantity'], // Hanya ada untuk peminjaman alat
      purpose: json['purpose'] ?? '',
      startDate: DateTime.parse(json['loan_date'] ?? json['start_time']),
      endDate: DateTime.parse(json['return_date'] ?? json['end_time']),
      status: json['status'] ?? 'unknown',
    );
  }
}