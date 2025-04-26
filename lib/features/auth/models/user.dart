class User {
  final String name;
  final String id; // Bisa digunakan untuk NIM/NIDN
  final String email;
  final String phone;
  final String role; // Misalnya: "Mahasiswa" atau "Dosen"

  const User({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    this.role = "Mahasiswa", // Default role
  });

  // Method untuk mengubah data dari JSON (saat mengambil data dari backend)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String? ?? "Mahasiswa",
    );
  }

  // Method untuk mengubah data ke JSON (saat mengirim data ke backend)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'phone': phone,
      'role': role,
    };
  }
}