import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_asteroids/objects/particle.dart';
import 'package:flutter_asteroids/vector.dart';

void drawExplosion(Canvas canvas, Size size, Vector position) {
  final List<Particle> particles = _getParticles(position);

  final Paint paint = Paint()
    ..color = _generateExplosionColors()
    ..style = PaintingStyle.stroke
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 32)
    ..strokeWidth = 2;

  for (final Particle particle in particles) {
    final Path path = Path();
    final double angle = particle.rotation;

    final double x1 = particle.position.x - particle.size * cos(angle);
    final double y1 = particle.position.y - particle.size * sin(angle);
    final double x2 = particle.position.x + particle.size * cos(angle);
    final double y2 = particle.position.y + particle.size * sin(angle);

    path
      ..moveTo(x1, y1)
      ..lineTo(x2, y2);

    canvas.drawPath(path, paint);
  }
}

List<Particle> _getParticles(Vector position) {
  const int numFragments = 100;

  final Random random = Random();

  final List<Particle> particles = <Particle>[];

  if (particles.isEmpty) {
    for (int i = 0; i < numFragments; i++) {
      final double angle = random.nextDouble() * 2 * pi;
      final double speed = random.nextDouble() * 2;
      final double size = random.nextDouble() * 20;
      final double rotation = random.nextDouble() * 2 * pi;

      particles.add(
        Particle(
          position: position,
          velocity: Vector(speed * cos(angle), speed * sin(angle)),
          size: size,
          rotation: rotation,
        ),
      );
    }
  }

  return particles;
}

Color _generateExplosionColors() {
  final Random random = Random();

  final List<Color> colors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
  ];

  return colors[random.nextInt(colors.length)];
}
