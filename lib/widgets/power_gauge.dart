import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class PowerGauge extends StatelessWidget {
  final double power;
  final double maxPower;
  final String unit;

  const PowerGauge({
    super.key,
    required this.power,
    this.maxPower = 5000.0,
    this.unit = 'W',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      child: CustomPaint(
        painter: GaugePainter(
          power: power,
          maxPower: maxPower,
          unit: unit,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${power.toStringAsFixed(0)}$unit',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getGaugeColor(power, maxPower),
                ),
              ),
              Text(
                'Live Power Usage',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getGaugeColor(double power, double maxPower) {
    final ratio = power / maxPower;
    if (ratio < 0.3) return AppTheme.accentGreen;
    if (ratio < 0.7) return AppTheme.warningOrange;
    return Colors.red;
  }
}

class GaugePainter extends CustomPainter {
  final double power;
  final double maxPower;
  final String unit;

  GaugePainter({
    required this.power,
    required this.maxPower,
    required this.unit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Background arc
    final backgroundPaint = Paint()
      ..color = AppTheme.cardSurfaceDark
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      math.pi,
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressRatio = (power / maxPower).clamp(0.0, 1.0);
    final sweepAngle = math.pi * progressRatio;

    final progressPaint = Paint()
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (progressRatio < 0.3) {
      progressPaint.color = AppTheme.accentGreen;
    } else if (progressRatio < 0.7) {
      progressPaint.color = AppTheme.warningOrange;
    } else {
      progressPaint.color = Colors.red;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi,
      sweepAngle,
      false,
      progressPaint,
    );

    // Needle
    final needleAngle = -math.pi + (math.pi * progressRatio);
    final needleLength = radius - 30;
    final needleEnd = Offset(
      center.dx + needleLength * math.cos(needleAngle),
      center.dy + needleLength * math.sin(needleAngle),
    );

    final needlePaint = Paint()
      ..color = AppTheme.textPrimary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(center, needleEnd, needlePaint);

    // Center dot
    final centerPaint = Paint()
      ..color = AppTheme.textPrimary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, centerPaint);

    // Scale marks
    final scalePaint = Paint()
      ..color = AppTheme.textTertiary
      ..strokeWidth = 2;

    for (int i = 0; i <= 10; i++) {
      final angle = -math.pi + (math.pi * i / 10);
      final startRadius = radius - 10;
      final endRadius = radius - 20;

      final startPoint = Offset(
        center.dx + startRadius * math.cos(angle),
        center.dy + startRadius * math.sin(angle),
      );
      final endPoint = Offset(
        center.dx + endRadius * math.cos(angle),
        center.dy + endRadius * math.sin(angle),
      );

      canvas.drawLine(startPoint, endPoint, scalePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is GaugePainter && oldDelegate.power != power;
  }
}

