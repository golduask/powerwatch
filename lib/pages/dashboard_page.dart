import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/power_data.dart';
import '../services/mock_data_service.dart';
import '../widgets/power_gauge.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final MockDataService _dataService = MockDataService();
  PowerData? _currentData;
  bool _isRelayOn = false;

  @override
  void initState() {
    super.initState();
    _isRelayOn = _dataService.isRelayOn;
    _loadData();
  }

  void _loadData() {
    setState(() {
      _currentData = _dataService.getCurrentPowerData();
    });
  }

  void _toggleRelay() {
    setState(() {
      _dataService.toggleRelay();
      _isRelayOn = _dataService.isRelayOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentData == null) {
      return const Scaffold(
        backgroundColor: AppTheme.backgroundDark,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryBlue),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Hello, John Doe',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here\'s your current power status',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Main Gauge
              Center(
                child: PowerGauge(
                  power: _currentData!.power,
                  maxPower: 5000.0,
                  unit: 'W',
                ),
              ),
              const SizedBox(height: 32),

              // Data Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildDataCard(
                    icon: Icons.electrical_services,
                    title: 'Voltage',
                    value: '${_currentData!.voltage.toStringAsFixed(1)} V',
                    color: AppTheme.primaryBlue,
                  ),
                  _buildDataCard(
                    icon: Icons.flash_on,
                    title: 'Current',
                    value: '${_currentData!.current.toStringAsFixed(1)} A',
                    color: AppTheme.accentGreen,
                  ),
                  _buildDataCard(
                    icon: Icons.power,
                    title: 'Energy Today',
                    value: '${_currentData!.energyTodayKwh.toStringAsFixed(1)} kWh',
                    color: AppTheme.warningOrange,
                  ),
                  _buildDataCard(
                    icon: Icons.currency_rupee,
                    title: 'Estimated Bill',
                    value: '₹${_currentData!.estimatedBill.toStringAsFixed(0)}',
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Remote Control Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remote Control',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Main Circuit Relay',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _isRelayOn ? 'ON' : 'OFF',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: _isRelayOn ? AppTheme.accentGreen : AppTheme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isRelayOn,
                            onChanged: (value) => _toggleRelay(),
                            activeColor: AppTheme.primaryBlue,
                            activeTrackColor: AppTheme.primaryBlue.withOpacity(0.3),
                            inactiveThumbColor: AppTheme.textSecondary,
                            inactiveTrackColor: AppTheme.textTertiary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Refresh Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: _loadData,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Data'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cardSurfaceDark,
                    foregroundColor: AppTheme.textPrimary,
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

