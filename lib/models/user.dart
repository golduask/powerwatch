class User {
  final String id;
  final String name;
  final String email;
  final double tariffRate;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.tariffRate = 8.50,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      tariffRate: json['tariff_rate']?.toDouble() ?? 8.50,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tariff_rate': tariffRate,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    double? tariffRate,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      tariffRate: tariffRate ?? this.tariffRate,
    );
  }
}

