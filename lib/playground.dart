import 'package:flutter/material.dart';
import 'package:flutter_asteroids/ship.dart';

class Playground extends CustomPainter {
  Playground(this.ship);

  final Ship ship;

  @override
  void paint(Canvas canvas, Size size) {
    ship.render(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
