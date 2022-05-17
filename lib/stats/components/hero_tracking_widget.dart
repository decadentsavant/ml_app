import 'dart:math';
import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw circle
    Paint circle = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = 150;
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }


}