import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../constants.dart';

class PlatformWidgets {
  static Widget button({Widget child, Function onPressed, Color color}) {
    return Platform.isAndroid
        ? RaisedButton(
            child: child,
            onPressed: onPressed,
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          )
        : CupertinoButton(
            child: child,
            onPressed: onPressed,
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          );
  }

  static Widget enableDisableButton(
      {Widget child,
      Function onPressed,
      Color color,
      double width,
      bool enabled}) {
    var button = SizedBox(
      height: 50.0,
      width: width,
      child: Card(
        child: child,
        color: enabled ? color : Colors.white70,
      ),
    );

    return enabled ? InkWell(child: button, onTap: onPressed) : button;
  }

  static void showThisDialog(
      {BuildContext context, String title, String message}) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('$title'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
          content: SizedBox(
            height: 45.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EnableDisableButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final Color color;
  final VoidCallback onPressed;

  const EnableDisableButton(
      {Key key,
      this.enabled = false,
      @required this.text,
      this.color = AppColors.primary,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .button
          .apply(color: Colors.white, fontFamily: 'OpenSans-SemiBold'),
    );
    return SizedBox(
      height: 48.0,
      width: MediaQuery.of(context).size.width * 9 / 10,
      child: Platform.isAndroid
          ? RaisedButton(
              child: child,
              color: color,
              elevation: Constants.fourBy1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.eightBy1)),
              onPressed: enabled ? onPressed : null,
            )
          : CupertinoButton(
              child: child,
              color: color,
              borderRadius: BorderRadius.circular(Constants.eightBy1),
              onPressed: enabled ? onPressed : null,
            ),
    );
  }
}
