import 'package:flutter/material.dart';
import 'package:flutter_asteroids/objects/physical_object.dart';
import 'package:flutter_asteroids/vector.dart';

class Laser extends PhysicalObject {
  Laser({
    required this.size,
    required super.position,
    required this.angle,
    required this.shipRadius,
    super.speed = 10,
    super.radius = 2,
  }) {
    _velocity = Vector.fromAngle(angle) * speed;
  }

  final Size size;
  final double shipRadius;

  double angle;

  Vector _velocity = Vector.zero();

  @override
  void update() => position += _velocity;

  @override
  void render(Canvas canvas) => canvas
    ..save()
    ..translate(position.x, position.y)
    ..drawCircle(
      (Vector.fromAngle(angle) * shipRadius).toOffset,
      radius,
      Paint()
        ..color = Colors.red
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 8),
    )
    ..restore();
}
