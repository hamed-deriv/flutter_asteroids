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
