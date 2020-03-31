import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

final Color supportingTextColor = Color(0x000000);
final TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'OpenSans-Regular',
    letterSpacing: 0.15,
    color: Colors.black.withOpacity(.87));
final TextStyle supportingTextStyle = TextStyle(
    fontSize: 16,
    fontFamily: 'OpenSans-Regular',
    letterSpacing: 0.15,
    color: Colors.black.withOpacity(.60));

class ErrorDialog extends StatelessWidget {
  final String title, content, buttonText;
  final VoidCallback onPressed;
  final Widget actions;

  ErrorDialog(
      {@required this.title,
      @required this.content,
      this.buttonText = "Retry",
      this.onPressed,
      this.actions});

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 8.0),
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: FlareActor.asset(
              AssetFlare(bundle: rootBundle, name: 'assets/flare/error.flr'),
              animation: 'play',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: titleTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    content,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: supportingTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Divider(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: actions ??
                Align(
                  alignment: Platform.isAndroid
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: FlatButton(
                    onPressed: onPressed ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Text(
                      buttonText.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colors.indigo),
                    ),
                  ),
                ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
    return Dialog(
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.sixteenBy1)),
      child: child,
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title, content, buttonText;
  final VoidCallback onPressed;
  final Widget actions;

  SuccessDialog(
      {@required this.title,
      @required this.content,
      this.buttonText = "Done",
      this.onPressed,
      this.actions});

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 8.0),
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: FlareActor.asset(
              AssetFlare(bundle: rootBundle, name: 'assets/flare/success.flr'),
              animation: 'Untitled',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: titleTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    content,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: supportingTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Divider(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: actions ??
                Align(
                  alignment: Platform.isAndroid
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: FlatButton(
                    onPressed: onPressed ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Text(
                      buttonText.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colors.indigo),
                    ),
                  ),
                ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
    return Dialog(
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.sixteenBy1)),
      child: child,
    );
  }
}

class WarningDialog extends StatelessWidget {
  final String title, content, buttonText;
  final VoidCallback onPressed;
  final Widget actions;

  WarningDialog(
      {@required this.title,
      @required this.content,
      this.buttonText = "Done",
      this.onPressed,
      this.actions});

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 8.0),
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: FlareActor.asset(
              AssetFlare(bundle: rootBundle, name: 'assets/flare/warning.flr'),
              animation: 'warning',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: titleTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment:
                Platform.isAndroid ? Alignment.centerLeft : Alignment.center,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    content,
                    textAlign:
                        Platform.isAndroid ? TextAlign.left : TextAlign.center,
                    style: supportingTextStyle,
                  ),
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Divider(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: actions ??
                Align(
                  alignment: Platform.isAndroid
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: FlatButton(
                    onPressed: onPressed ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Text(
                      buttonText.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colors.indigo),
                    ),
                  ),
                ),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
    return Dialog(
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.sixteenBy1)),
      child: child,
    );
  }
}
