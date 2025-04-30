class User {
  final String name;
  final String id; // Bisa digunakan untuk NIM/NIDN
  final String email;
  final String phone;
  final String role; // Role wajib

  const User({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.role, // Hapus default value
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String, // Role wajib ada di JSON
    );
  }

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