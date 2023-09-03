import 'package:flutter/material.dart';
import 'package:flutter_asteroids/vector.dart';

Vector wrapEdges(Vector position, double radius, Size size) {
  if (position.x < -radius) {
    position.x = size.width + radius;
  } else if (position.x > size.width + radius) {
    position.x = -radius;
  }

  if (position.y < -radius) {
    position.y = size.height + radius;
  } else if (position.y > size.height + radius) {
    position.y = -radius;
  }

  return position;
}

bool isOffScreen(Vector position, double radius, Size size) =>
    position.x < -radius ||
    position.x > size.width + radius ||
    position.y < -radius ||
    position.y > size.height + radius;

bool isColliding({
  required Vector positionA,
  required double radiusA,
  required Vector positionB,
  required double radiusB,
}) {
  final double distance = (positionA - positionB).magnitude;

  return distance < radiusA + radiusB;
}
