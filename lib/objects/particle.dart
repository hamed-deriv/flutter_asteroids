import 'package:flutter_asteroids/vector.dart';

class Particle {
  Particle({
    required this.size,
    required this.position,
    required this.velocity,
    required this.rotation,
  });

  final double size;
  final Vector position;
  final Vector velocity;
  final double rotation;
}
