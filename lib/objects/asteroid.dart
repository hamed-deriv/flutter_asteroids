import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_asteroids/helpers.dart';
import 'package:flutter_asteroids/objects/physical_object.dart';
import 'package:flutter_asteroids/vector.dart';

class Asteroid extends PhysicalObject {
  Asteroid({
    required this.size,
    required super.position,
    super.speed = 0.5,
    super.radius = 50,
  }) {
    radius = Random().nextDouble() * radius / 2 + radius / 2;

    for (int i = 0; i < _totalVertices; i++) {
      _verticesOffset.add(Random().nextInt(radius ~/ 2) - radius / 4);
    }

    _velocity = Vector.random() * speed;
  }

  final Size size;

  Vector _velocity = Vector.zero();

  final int _totalVertices = Random().nextInt(10) + 5;
  final List<double> _verticesOffset = <double>[];

  @override
  void update() {
    position += _velocity;

    position = wrapEdges(this, size);
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..save()
      ..translate(position.x, position.y);

    _drawAsteroid(canvas);

    canvas.restore();
  }

  void _drawAsteroid(Canvas canvas) {
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2)
      ..style = PaintingStyle.stroke;

    final Paint paint = Paint()..color = Colors.black;

    final List<Offset> points = <Offset>[];

    for (int i = 0; i < _totalVertices; i++) {
      final double angle = 2 * pi * i / _totalVertices;
      final Vector vertex =
          Vector.fromAngle(angle) * (radius + _verticesOffset[i]);

      points.add(vertex.toOffset);
    }

    canvas
      ..drawPath(
        Path()..addPolygon(points, true),
        paint,
      )
      ..drawPath(
        Path()..addPolygon(points, true),
        borderPaint,
      );
  }
}
