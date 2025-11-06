import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';

class UsageBarChart extends StatelessWidget {
  final List<double> data;
  final String timeFrame;
  final double maxValue;

  const UsageBarChart({
    super.key,
    required this.data,
    required this.timeFrame,
    this.maxValue = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          maxY: maxValue,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: AppTheme.cardSurfaceDark,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String label;
                switch (timeFrame) {
                  case 'Day':
                    label = '${group.x}:00';
                    break;
                  case 'Week':
                    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    label = days[group.x];
                    break;
                  case 'Month':
                    label = 'Week ${group.x + 1}';
                    break;
                  default:
                    label = '${group.x}';
                }
                return BarTooltipItem(
                  '$label\n${rod.toY.toStringAsFixed(1)} kWh',
                  const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String label;
                  switch (timeFrame) {
                    case 'Day':
                      if (value % 4 == 0) {
                        label = '${value.toInt()}:00';
                      } else {
                        return const SizedBox.shrink();
                      }
                      break;
                    case 'Week':
                      final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                      label = days[value.toInt()];
                      break;
                    case 'Month':
                      label = 'W${value.toInt() + 1}';
                      break;
                    default:
                      label = '${value.toInt()}';
                  }
                  return Text(
                    label,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 10,
                    ),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;
            
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: _getBarColor(value, maxValue),
                  width: timeFrame == 'Day' ? 12 : 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue / 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppTheme.cardSurfaceDark,
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getBarColor(double value, double maxValue) {
    final ratio = value / maxValue;
    if (ratio < 0.3) return AppTheme.accentGreen;
    if (ratio < 0.7) return AppTheme.warningOrange;
    return Colors.red;
  }
}

