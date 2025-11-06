class PowerData {
  final double voltage;
  final double current;
  final double power;
  final double energyTodayKwh;
  final double estimatedBill;

  PowerData({
    required this.voltage,
    required this.current,
    required this.power,
    required this.energyTodayKwh,
    required this.estimatedBill,
  });

  factory PowerData.fromJson(Map<String, dynamic> json) {
    return PowerData(
      voltage: json['voltage']?.toDouble() ?? 0.0,
      current: json['current']?.toDouble() ?? 0.0,
      power: json['power']?.toDouble() ?? 0.0,
      energyTodayKwh: json['energy_today_kwh']?.toDouble() ?? 0.0,
      estimatedBill: json['estimated_bill']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voltage': voltage,
      'current': current,
      'power': power,
      'energy_today_kwh': energyTodayKwh,
      'estimated_bill': estimatedBill,
    };
  }
}

