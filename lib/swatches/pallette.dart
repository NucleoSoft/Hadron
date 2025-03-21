import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class ColorSwatch {
  final String name;
  final Map<int, Color> swatch;

  ColorSwatch({required this.name, required this.swatch});

  Color operator [](int index) => swatch[index]!;
}

final primarySwatch = ColorSwatch(
  name: 'Primary',
  swatch: {
        50: const Color(0xfff2e5ff),
        100: const Color(0xffd9b3ff),
        200: const Color(0xffbf80ff),
        300: const Color(0xffa64dff),
        400: const Color(0xff8c1aff),
        500: const Color(0xff8c1aff),
        600: const Color(0xff5900b3),
        700: const Color(0xff400080),
        800: const Color(0xff26004d),
        900: const Color(0xff0d001a),
      },
),

secondarySwatch = ColorSwatch(
  name: 'Secondary',
  swatch:  {
        50: const Color(0xffe5ffee),
        100: const Color(0xffb3ffcc),
        200: const Color(0xff80ffaa),
        300: const Color(0xff4dff88),
        400: const Color(0xff1aff66),
        500: const Color(0xff00e64d),
        600: const Color(0xff00b33c),
        700: const Color(0xff00802b),
        800: const Color(0xff004d1a),
        900: const Color(0xff001a09),
      },
      ),
      ternarySwatch = ColorSwatch(
      name: 'Ternary',
      swatch: {
        50: const Color(0xffe5ffff),
        100: const Color(0xffb3ffff),
        200: const Color(0xff80ffff),
        300: const Color(0xff4dffff),
        400: const Color(0xff1affff),
        500: const Color(0xff00e5e6),
        600: const Color(0xff00b2b3),
        700: const Color(0xff007f80),
        800: const Color(0xff004c4d),
        900: const Color(0xff00191a),
      },
    ),
    surfaceSwatch = ColorSwatch(
      name: 'Surface',
      swatch: {
        50: const Color(0xffecf0f8),
        100: const Color(0xffc7d1eb),
        200: const Color(0xffa1b3dd),
        300: const Color(0xff7b95d0),
        400: const Color(0xff5676c3),
        500: const Color(0xff3c5da9),
        600: const Color(0xff2f4884),
        700: const Color(0xff22335e),
        800: const Color(0xff141f38),
        900: const Color(0xff070a13),
      },
    );

    var buttonColors = WindowButtonColors(
      iconNormal: surfaceSwatch[400],
      mouseOver: surfaceSwatch[200],
      mouseDown: surfaceSwatch[500],
      iconMouseOver: surfaceSwatch[700],
      iconMouseDown: surfaceSwatch[900],
    );