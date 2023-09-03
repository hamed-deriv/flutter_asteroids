import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final Ship ship = Ship(
    size: size,
    position: Vector(size.width / 2, size.height / 2),
  );

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 16), (_) {
      ship.update();

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: onKeyEvent,
              child: CustomPaint(
                size: size,
                painter: Playground(ship: ship),
              ),
            ),
          ),
        ),
      );

  void onKeyEvent(RawKeyEvent event) {
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
