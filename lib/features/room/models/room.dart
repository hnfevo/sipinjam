class Room {
  final int id;
  final String name;
  final String location;
  final int capacity;
  final bool available;
  final String? description;

  const Room({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.available,
    this.description,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      capacity: json['capacity'] as int,
      available: (json['available'] as int) == 1, // Konversi int ke bool
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'capacity': capacity,
      'available': available ? 1 : 0, // Konversi bool ke int saat mengirim data
      'description': description,
    };
  }
}