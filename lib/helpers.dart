import 'package:flutter/material.dart';
import 'package:flutter_asteroids/objects/physical_object.dart';
import 'package:flutter_asteroids/vector.dart';

Vector wrapEdges(PhysicalObject object, Size size) {
  final double x = object.position.x;
  final double y = object.position.y;

  if (x < 0) {
    object.position = Vector(size.width, y);
  } else if (x > size.width) {
    object.position = Vector(0, y);
  }

  if (y < 0) {
    object.position = Vector(x, size.height);
  } else if (y > size.height) {
    object.position = Vector(x, 0);
  }

  return object.position;
}

bool isOffScreen(PhysicalObject object, Size size) =>
    object.position.x < 0 ||
    object.position.x > size.width ||
    object.position.y < 0 ||
    object.position.y > size.height;

bool isColliding({
  required PhysicalObject objectA,
  required PhysicalObject objectB,
}) {
  final double distance = (objectA.position - objectB.position).magnitude;

  return distance < objectA.radius + objectB.radius;
}
