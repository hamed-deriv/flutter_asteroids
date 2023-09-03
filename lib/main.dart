import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asteroids/asteroid.dart';
import 'package:flutter_asteroids/playground.dart';
import 'package:flutter_asteroids/ship.dart';
import 'package:flutter_asteroids/vector.dart';

const Size size = Size(600, 600);

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int score = 0;

  final Ship ship = Ship(
    size: size,
    position: Vector(size.width / 2, size.height / 2),
  );

  final List<Asteroid> asteroids = <Asteroid>[];

  @override
  void initState() {
    super.initState();

    _generateAstroids();

    Timer.periodic(const Duration(milliseconds: 16), (_) {
      ship.update();

      for (final Asteroid asteroid in asteroids) {
        asteroid.update();
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _onKeyEventHandler,
        child: MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                _buildScore(),
                _buildPlayground(),
              ],
            ),
          ),
        ),
      );

  Widget _buildScore() => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Score: $score',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );

  Widget _buildPlayground() => Center(
        child: CustomPaint(
          size: size,
          painter: Playground(ship: ship, asteroids: asteroids),
        ),
      );

  void _generateAstroids() {
    for (int i = 0; i < 5; i++) {
      asteroids.add(
        Asteroid(
          size: size,
          position: Vector(
            Random().nextDouble() * size.width,
            Random().nextDouble() * size.height,
          ),
        ),
      );
    }
  }

  void _onKeyEventHandler(RawKeyEvent event) {
    switch (event.runtimeType) {
      case RawKeyDownEvent:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowLeft:
            ship.isTurningLeft = true;
            break;
          case LogicalKeyboardKey.arrowRight:
            ship.isTurningRight = true;
            break;
          case LogicalKeyboardKey.arrowUp:
            ship.isThrusting = true;
            break;
        }
      case RawKeyUpEvent:
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowLeft:
            ship.isTurningLeft = false;
            break;
          case LogicalKeyboardKey.arrowRight:
            ship.isTurningRight = false;
            break;
          case LogicalKeyboardKey.arrowUp:
            ship.isThrusting = false;
            break;
        }
        break;
    }
  }
}
