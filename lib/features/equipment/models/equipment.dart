class Equipment {
  final int id;
  final String name;
  final String? description;
  final int quantity;
  final int availableQuantity;

  const Equipment({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.availableQuantity,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      quantity: json['quantity'] as int,
      availableQuantity: json['available_quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'available_quantity': availableQuantity,
    };
  }
}