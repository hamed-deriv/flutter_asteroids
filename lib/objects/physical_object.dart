import 'package:flutter/material.dart';
import 'package:flutter_asteroids/vector.dart';

abstract class PhysicalObject {
  PhysicalObject({
    required this.position,
    required this.speed,
    required this.radius,
  });

  Vector position;
  double speed;
  double radius;

  void update();

  void render(Canvas canvas);
}
