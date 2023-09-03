import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_asteroids/enums.dart';
import 'package:flutter_asteroids/helpers.dart';
import 'package:flutter_asteroids/vector.dart';

class Ship {
  Ship({
    required this.size,
    required this.position,
    this.speed = 0.2,
    this.rotationSpeed = 0.1,
    this.drag = 0.98,
  });

  Size size;
  Vector position;
  double speed;
  double rotationSpeed;
  double drag;

  final double radius = 10;

  double _rotation = 0;
  Vector _velocity = Vector.zero();

  bool isTurningLeft = false;
  bool isTurningRight = false;
  bool isThrusting = false;

  void update() {
    if (isTurningLeft) {
      _turn(Rotation.left);
    }

    if (isTurningRight) {
      _turn(Rotation.right);
    }

    if (isThrusting) {
      _thrust();
    }

    position += _velocity;
    position = wrapEdges(position, radius, size);

    _velocity *= drag;
  }

  void render(Canvas canvas) {
    canvas.save();

    canvas.translate(position.x, position.y);
    canvas.rotate(_rotation + pi / 2);

    _drawThrust(canvas);
    _drawShip(canvas);

    canvas.restore();
  }

  void _turn(Rotation rotation) =>
      _rotation += (rotation == Rotation.left ? -1 : 1) * rotationSpeed;

  void _thrust() => _velocity += Vector.fromAngle(_rotation) * speed;

  void _drawShip(Canvas canvas) {
    final Paint paintBorder = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, -radius)
      ..lineTo(radius, radius)
      ..lineTo(0, radius / 2)
      ..lineTo(-radius, radius)
      ..close();

    canvas.drawPath(path, paintBorder);
    canvas.drawPath(path, fillPaint);
  }

  void _drawThrust(Canvas canvas) {
    final Paint thrustPaint = Paint()
      ..color = Random().nextBool() ? Colors.yellow : Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    if (isThrusting) {
      final Path flame = Path()
        ..moveTo(0, radius / 2)
        ..lineTo(-radius / 2, radius)
        ..lineTo(0, radius * Random().nextDouble() * 2.5 + 1.5)
        ..lineTo(radius / 2, radius)
        ..close();

      canvas.drawPath(flame, thrustPaint);
    }
  }
}
