import 'dart:math';
import '../models/power_data.dart';
import '../models/alert.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  final Random _random = Random();
  bool _isRelayOn = false;

  // Mock real-time power data
  PowerData getCurrentPowerData() {
    // Simulate varying power consumption
    final basePower = 500.0;
    final variation = _random.nextDouble() * 200.0;
    final power = basePower + variation;
    
    return PowerData(
      voltage: 230.0 + (_random.nextDouble() * 10.0 - 5.0),
      current: power / 230.0,
      power: power,
      energyTodayKwh: 8.3 + (_random.nextDouble() * 2.0),
      estimatedBill: (8.3 + (_random.nextDouble() * 2.0)) * 8.50,
    );
  }

  // Mock historical data for different time frames
  List<double> getDayData() {
    return List.generate(24, (index) {
      // Simulate typical daily usage pattern
      if (index >= 6 && index <= 9) return 0.8 + _random.nextDouble() * 0.4; // Morning peak
      if (index >= 18 && index <= 22) return 1.2 + _random.nextDouble() * 0.6; // Evening peak
      if (index >= 0 && index <= 5) return 0.1 + _random.nextDouble() * 0.2; // Night low
      return 0.3 + _random.nextDouble() * 0.5; // Regular usage
    });
  }

  List<double> getWeekData() {
    return [12.1, 15.3, 14.8, 13.5, 16.2, 18.9, 17.4];
  }

  List<double> getMonthData() {
    return [65.2, 72.8, 68.9, 75.3];
  }

  // Mock alerts data
  List<Alert> getAlerts() {
    return [
      Alert(
        icon: 'warning',
        title: 'High Usage Detected',
        description: 'Your consumption peaked at 3500W at 8:15 PM.',
        timestamp: '2 hours ago',
      ),
      Alert(
        icon: 'info',
        title: 'Relay Turned On',
        description: 'The main circuit relay was activated remotely.',
        timestamp: 'Yesterday',
      ),
      Alert(
        icon: 'leaf',
        title: 'Low Overnight Usage',
        description: 'Great job! Your standby power was minimal last night.',
        timestamp: 'Yesterday',
      ),
      Alert(
        icon: 'trending_up',
        title: 'Weekly Usage Increase',
        description: 'Your usage increased by 15% compared to last week.',
        timestamp: '3 days ago',
      ),
      Alert(
        icon: 'eco',
        title: 'Energy Efficiency Tip',
        description: 'Consider using LED bulbs to reduce consumption by 20%.',
        timestamp: '1 week ago',
      ),
    ];
  }

  // Relay control
  bool get isRelayOn => _isRelayOn;
  
  void toggleRelay() {
    _isRelayOn = !_isRelayOn;
  }

  // Simulate data updates
  Stream<PowerData> getPowerDataStream() async* {
    while (true) {
      yield getCurrentPowerData();
      await Future.delayed(const Duration(seconds: 3));
    }
  }
}

