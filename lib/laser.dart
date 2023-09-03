import 'package:flutter/material.dart';
import 'package:flutter_asteroids/vector.dart';

class Laser {
  Laser({
    required this.size,
    required this.position,
    required this.angle,
    required this.shipRadius,
    this.radius = 2,
    this.speed = 10,
  }) {
    _velocity = Vector.fromAngle(angle) * speed;
  }

  final Size size;
  final double speed;
  final double radius;
  final double shipRadius;

  Vector position;
  double angle;

  Vector _velocity = Vector.zero();

  void update() => position += _velocity;

  void render(Canvas canvas) => canvas
    ..save()
    ..translate(position.x, position.y)
    ..drawCircle(
      (Vector.fromAngle(angle) * shipRadius).toOffset,
      radius,
      Paint()..color = Colors.red,
    )
    ..restore();
}
