import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asteroids/asteroid.dart';
import 'package:flutter_asteroids/helpers.dart';
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
  final List<Asteroid> asteroids = <Asteroid>[];

  late final Ship ship;

  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();

    _generateAstroids();

    ship = Ship(
      size: size,
      position: Vector(size.width / 2, size.height / 2),
      asteroids: asteroids,
    );

    Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!isGameOver) {
        ship.update();
      }

      for (final Asteroid asteroid in asteroids) {
        asteroid.update();
      }

      _checkShipCollision();
      _checkLaserCollision();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: isGameOver ? null : _onKeyEventHandler,
        child: MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                _buildScore(),
                _buildPlayground(),
                if (isGameOver) _buildGameOver(),
              ],
            ),
          ),
        ),
      );

  Widget _buildGameOver() => Align(
        child: Text(
          'Game Over\nScore: $score\n🙁',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 54,
            fontWeight: FontWeight.bold,
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
          painter: Playground(
            ship: ship,
            asteroids: asteroids,
            gameOver: isGameOver,
          ),
        ),
      );

  void _generateAstroids() {
    for (int i = 0; i < 8; i++) {
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

  void _checkShipCollision() {
    for (final Asteroid asteroid in asteroids) {
      if (isColliding(
        positionA: ship.position,
        radiusA: ship.radius,
        positionB: asteroid.position,
        radiusB: asteroid.radius,
      )) {
        isGameOver = true;

        break;
      }
    }
  }

  void _checkLaserCollision() {
    for (int i = ship.lasers.length - 1; i >= 0; i--) {
      for (final Asteroid asteroid in asteroids) {
        if (isColliding(
          positionA: ship.lasers[i].position,
          radiusA: ship.lasers[i].radius,
          positionB: asteroid.position,
          radiusB: asteroid.radius,
        )) {
          score += 10;

          ship.lasers.remove(ship.lasers[i]);

          final double newRadius = asteroid.radius / 2;

          if (newRadius > 5) {
            for (int i = 0; i < 2; i++) {
              asteroids.add(
                Asteroid(
                  size: size,
                  position: asteroid.position,
                  speed: asteroid.speed * 2,
                  radius: newRadius,
                ),
              );
            }
          }

          asteroids.remove(asteroid);

          break;
        }
      }
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
          case LogicalKeyboardKey.space:
            ship.shoot();
            break;
        }
    }
  }
}
