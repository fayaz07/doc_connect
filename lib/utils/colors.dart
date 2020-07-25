import 'package:flutter/material.dart' show Color, Colors;

class AppColors {
  static final List<Color> cardColors = [
    "ffadad",
    "ffd6a5",
    "fdffb6",
    "caffbf",
    "9bf6ff",
    "a0c4ff",
    "bdb2ff",
    "ffc6ff",
    "ffb5a7",
    "fcd5ce",
    "f8edeb",
    "f9dcc4",
    "fec89a",
    "ffcbf2",
    "f3c4fb",
    "ecbcfd",
    "e5b3fe",
    "e2afff",
    "deaaff",
    "d8bbff",
    "d0d1ff",
    "c8e7ff",
    "c0fdff",
    "7bdff2",
    "b2f7ef",
    "eff7f6",
    "f7d6e0",
    "f2b5d4"
  ].toSet().map((e) => Color(int.parse("0xff$e"))).toList();

  static const infoColor = Colors.lightBlue;
  static const danger = Colors.redAccent;
  static const green = Colors.green;
}
