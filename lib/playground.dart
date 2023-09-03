import 'package:flutter/material.dart';
import 'package:flutter_asteroids/objects/physical_object.dart';
import 'package:flutter_asteroids/objects/ship.dart';

class Playground extends CustomPainter {
  Playground({
    required this.ship,
    required this.asteroids,
    required this.gameOver,
    this.drawDebug = false,
  });

  final Ship ship;
  final List<PhysicalObject> asteroids;
  final bool gameOver;
  final bool drawDebug;

  @override
  void paint(Canvas canvas, Size size) {
    if (drawDebug) {
      _drawBorder(canvas, size);
    }

    for (final PhysicalObject asteroid in asteroids) {
      asteroid.render(canvas);
    }

    gameOver ? ship.explode(canvas) : ship.render(canvas);
  }

  void _drawBorder(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
