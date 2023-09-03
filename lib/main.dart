import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_asteroids/playground.dart';
import 'package:flutter_asteroids/ship.dart';
import 'package:flutter_asteroids/vector.dart';

const Size size = Size(400, 400);

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Ship ship = Ship(Vector(size.width / 2, size.height / 2));

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 16), (_) => {});
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CustomPaint(
              size: size,
              painter: Playground(ship),
            ),
          ),
        ),
      );
}
