import 'package:flutter/material.dart';
import 'package:flutter_asteroids/vector.dart';

class Ship {
  Ship(this.position);

  Vector position;

  final double radius = 10;

  void render(Canvas canvas) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(position.x, position.y - radius)
      ..lineTo(position.x + radius, position.y + radius)
      ..lineTo(position.x, position.y + radius / 2)
      ..lineTo(position.x - radius, position.y + radius)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, fillPaint);
  }
}
