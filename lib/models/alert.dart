class Alert {
  final String icon;
  final String title;
  final String description;
  final String timestamp;

  Alert({
    required this.icon,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      icon: json['icon'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'description': description,
      'timestamp': timestamp,
    };
  }
}

