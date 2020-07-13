import 'package:flutter/material.dart';

class VerifiedTick extends StatelessWidget {
  final double size;

  const VerifiedTick({Key key, this.size = 32.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/verified.png',
      height: size,
      width: size,
    );
  }
}
