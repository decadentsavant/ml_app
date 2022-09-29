import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ml_app/theme/theme.dart';

class ProgressCircle extends CustomPainter {
  ProgressCircle({
    required this.currentProgress,
    required this.radius,
    required this.strokeCircle,
  });

  int currentProgress;
  double strokeCircle;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw circle
    final circle = Paint()
      ..strokeWidth = strokeCircle
      ..color = MLColors.primaryShadeLight1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, circle);

    // Draw overlay
    final overlayArc = Paint()
      ..strokeWidth = strokeCircle
      ..color = MLColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final angle = 2 * pi * (currentProgress / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / .6666,
      angle + .01,
      false,
      overlayArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
