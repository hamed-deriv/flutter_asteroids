import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_asteroids/helpers.dart';
import 'package:flutter_asteroids/vector.dart';

class Asteroid {
  Asteroid({
    required this.size,
    required this.position,
    this.radius = 50,
  }) {
    radius = Random().nextDouble() * radius / 2 + radius / 2;

    for (int i = 0; i < _totalVertices; i++) {
      _verticesOffset.add(Random().nextInt(radius ~/ 2) - radius / 4);
    }

    velocity = Vector.random();
  }

  Size size;
  Vector position;
  double radius;

  Vector velocity = Vector.zero();
  final int _totalVertices = Random().nextInt(10) + 5;
  final List<double> _verticesOffset = <double>[];

  void update() {
    position += velocity;

    position = wrapEdges(position, radius, size);
  }

  void render(Canvas canvas) {
    canvas
      ..save()
      ..translate(position.x, position.y);

    _drawAsteroid(canvas);

    canvas.restore();
  }

  void _drawAsteroid(Canvas canvas) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final List<Offset> points = <Offset>[];

    for (int i = 0; i < _totalVertices; i++) {
      final double angle = 2 * pi * i / _totalVertices;
      final double x = (radius + _verticesOffset[i]) * cos(angle);
      final double y = (radius + _verticesOffset[i]) * sin(angle);

      points.add(Offset(x, y));
    }

    canvas.drawPath(
      Path()..addPolygon(points, true),
      paint,
    );
  }
}
