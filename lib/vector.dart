import 'dart:math';

class Vector {
  Vector(this.x, this.y);

  double x;
  double y;

  factory Vector.zero() => Vector(0, 0);

  factory Vector.fromAngle(double angle) => Vector(cos(angle), sin(angle));

  double get magnitude => sqrt(x * x + y * y);

  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);

  Vector operator *(double scalar) => Vector(x * scalar, y * scalar);

  @override
  String toString() => 'Vector($x, $y)';
}
