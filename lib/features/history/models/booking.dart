class Booking {
  final int id;
  final String userName;
  final String itemType; // "Ruangan" atau "Alat"
  final String itemName;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // "pending", "approved", "rejected", "returned"

  const Booking({
    required this.id,
    required this.userName,
    required this.itemType,
    required this.itemName,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Booking.fromRoomJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      userName: json['user']['name'] as String,
      itemType: 'Ruangan',
      itemName: json['room']['name'] as String,
      startDate: DateTime.parse(json['start_time'] as String),
      endDate: DateTime.parse(json['end_time'] as String),
      status: json['status'] as String,
    );
  }

  factory Booking.fromEquipmentJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      userName: json['user']['name'] as String,
      itemType: 'Alat',
      itemName: json['equipment']['name'] as String,
      startDate: DateTime.parse(json['loan_date'] as String),
      endDate: DateTime.parse(json['return_date'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'itemType': itemType,
      'itemName': itemName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
    };
  }
}