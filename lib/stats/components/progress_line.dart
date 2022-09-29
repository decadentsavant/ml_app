import 'package:flutter/material.dart';
import 'package:ml_app/theme/theme.dart';

class ProgressLine extends CustomPainter {
  ProgressLine({
    required this.currentProgress,
  });

  int currentProgress;
  double strokeLine = 5;
  final barP1 = Offset.zero;
  final barP2 = const Offset(200, 0);
  final progressP1 = Offset.zero;
  final progressP2 = const Offset(100, 0);


  @override
  void paint(Canvas canvas, Size size) {
    // Draw line
    final line = Paint()
      ..strokeWidth = strokeLine
      ..color = MLColors.primaryShadeLight1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(barP1, barP2, line);

    // Draw overlay
    final line2 = Paint()
      ..strokeWidth = (strokeLine + 3)
      ..color = MLColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(progressP1, progressP2, line2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
