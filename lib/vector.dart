import 'dart:math';

import 'package:flutter/material.dart';

class Vector {
  Vector(this.x, this.y);

  factory Vector.zero() => Vector(0, 0);

  factory Vector.fromAngle(double angle) => Vector(cos(angle), sin(angle));

  factory Vector.random() =>
      Vector(Random().nextDouble(), Random().nextDouble());

  double x;
  double y;

  Offset get toOffset => Offset(x, y);

  double get magnitude => sqrt(x * x + y * y);

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);

  Vector operator *(double scalar) => Vector(x * scalar, y * scalar);

  @override
  String toString() => 'Vector($x, $y)';
}
