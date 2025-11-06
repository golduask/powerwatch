import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/mock_data_service.dart';
import '../widgets/usage_bar_chart.dart';

class UsagePage extends StatefulWidget {
  const UsagePage({super.key});

  @override
  State<UsagePage> createState() => _UsagePageState();
}

class _UsagePageState extends State<UsagePage> {
  final MockDataService _dataService = MockDataService();
  String _selectedTimeFrame = 'Day';
  List<double> _currentData = [];
  double _maxValue = 20.0;

  final Map<String, List<double>> _timeFrameData = {
    'Day': [],
    'Week': [],
    'Month': [],
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _timeFrameData['Day'] = _dataService.getDayData();
      _timeFrameData['Week'] = _dataService.getWeekData();
      _timeFrameData['Month'] = _dataService.getMonthData();
      _currentData = _timeFrameData[_selectedTimeFrame]!;
      _maxValue = _currentData.reduce((a, b) => a > b ? a : b) * 1.2;
    });
  }

  void _selectTimeFrame(String timeFrame) {
    setState(() {
      _selectedTimeFrame = timeFrame;
      _currentData = _timeFrameData[timeFrame]!;
      _maxValue = _currentData.reduce((a, b) => a > b ? a : b) * 1.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Energy Usage',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track your consumption patterns',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Time Frame Selector
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardSurfaceDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: ['Day', 'Week', 'Month'].map((timeFrame) {
                    final isSelected = _selectedTimeFrame == timeFrame;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTimeFrame(timeFrame),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            timeFrame,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Chart
              Expanded(
                child: Card(
                  child: UsageBarChart(
                    data: _currentData,
                    timeFrame: _selectedTimeFrame,
                    maxValue: _maxValue,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Summary Statistics
              Text(
                'Summary',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Usage',
                      value: '${_currentData.reduce((a, b) => a + b).toStringAsFixed(1)} kWh',
                      icon: Icons.power,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Average Daily',
                      value: '${(_currentData.reduce((a, b) => a + b) / _currentData.length).toStringAsFixed(1)} kWh',
                      icon: Icons.trending_up,
                      color: AppTheme.accentGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Highest Peak',
                      value: '${_currentData.reduce((a, b) => a > b ? a : b).toStringAsFixed(1)} kWh',
                      icon: Icons.show_chart,
                      color: AppTheme.warningOrange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Lowest Usage',
                      value: '${_currentData.reduce((a, b) => a < b ? a : b).toStringAsFixed(1)} kWh',
                      icon: Icons.trending_down,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

