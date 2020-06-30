import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const _kDotSize = 8.0;
const _kDotPadding = 4.0;

class FilledDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_kDotPadding),
      child: SizedBox(
        height: _kDotSize,
        width: _kDotSize,
        child: Material(
          color: Theme.of(context).accentColor,
          type: MaterialType.circle,
        ),
      ),
    );
  }
}

class BlankDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(_kDotPadding),
      child: SizedBox(
        height: _kDotSize,
        width: _kDotSize,
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
