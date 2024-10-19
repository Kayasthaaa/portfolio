import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashPainter extends CustomPainter {
  final double lineToCircleProgress;
  final double particleProgress;

  SplashPainter({
    required this.lineToCircleProgress,
    required this.particleProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.2;

    _drawLineToCircle(canvas, size, center, radius, paint);
    _drawParticles(canvas, center, radius);
  }

  void _drawLineToCircle(
      Canvas canvas, Size size, Offset center, double radius, Paint paint) {
    if (lineToCircleProgress <= 0.5) {
      final lineProgress = lineToCircleProgress * 2;
      final start = Offset(0, size.height);
      final end = center;
      final currentEnd = Offset.lerp(start, end, lineProgress)!;
      canvas.drawLine(start, currentEnd, paint);
    } else {
      final circleProgress = (lineToCircleProgress - 0.5) * 2;
      final circlePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawCircle(center, radius * circleProgress, circlePaint);
    }
  }

  void _drawParticles(Canvas canvas, Offset center, double radius) {
    if (particleProgress > 0) {
      final particlePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      final random = math.Random(42);
      const particleCount = 50;

      for (var i = 0; i < particleCount; i++) {
        final angle = random.nextDouble() * 2 * math.pi;
        final distance = random.nextDouble() * radius * 1.5;
        final x = center.dx + math.cos(angle) * distance * particleProgress;
        final y = center.dy + math.sin(angle) * distance * particleProgress;
        final particleSize = random.nextDouble() * 4 * particleProgress;

        canvas.drawCircle(Offset(x, y), particleSize, particlePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SplashPainter oldDelegate) =>
      oldDelegate.lineToCircleProgress != lineToCircleProgress ||
      oldDelegate.particleProgress != particleProgress;
}
