import 'dart:io';

import 'package:doc_connect/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPlatformButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double elevation;
  final TextStyle style;
  final EdgeInsets padding;
  final double height, width, borderRadius;
  final Widget customChild;

  const AppPlatformButton(
      {Key key,
      this.onPressed,
      this.text,
      this.color,
      this.elevation = 4.0,
      this.style,
      this.padding,
      this.height,
      this.width,
      this.borderRadius = 16.0,
      this.customChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textChild = Text(
      text?.toUpperCase(),
      style: style ??
          TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
    );

    final child = customChild != null
        ? customChild
        : (height != null && width != null
            ? SizedBox(
                height: height,
                width: width,
                child: Center(child: textChild),
              )
            : textChild);

    return Platform.isIOS
        ? CupertinoButton(
            padding: padding,
            borderRadius: BorderRadius.circular(borderRadius),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          )
        : RaisedButton(
            padding: padding,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          );
  }
}

class ToggleSelectionButton extends StatelessWidget {
  final Function(bool isLogin) onChecked;
  final bool isLogin;

  const ToggleSelectionButton({Key key, this.onChecked, this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[]
        ..add(InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => onChecked(true),
            child: _getButton(isDarkTheme, "LOGIN", isLogin)))
        ..add(InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: () => onChecked(false),
            child: _getButton(isDarkTheme, "SIGNUP", !isLogin))),
    );
  }

  Widget _getButton(bool isDarkTheme, String text, bool selected) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            selected
                ? Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    color: isDarkTheme ? Colors.white : Colors.black,
                    child: SizedBox(
                      height: 4.0,
                      width: 70.0,
                    ),
                  )
                : SizedBox(
                    height: 4.0,
                  )
          ],
        ),
      );
}

class PictureButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final String text;

  const PictureButton({Key key, this.image, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: MediaQuery.of(context).size.width * 0.2,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.2 - 4.0,
              backgroundImage: AssetImage(image),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final int groupValue;
  final int value;
  final Function(int value) onChanged;
  final String text;

  const RadioButton(
      {Key key, this.groupValue, this.onChanged, this.text, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          '$text',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class TitleWithButton extends StatelessWidget {
  final String buttonText, title;
  final VoidCallback onPressed;

  const TitleWithButton(
      {Key key, this.buttonText = "More", @required this.onPressed, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: TitleText(title: title)),
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),
            ),
          ),
        ),
        // SizedBox(width: 8.0)
      ],
    );
  }
}

class AppBarAction extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const AppBarAction({Key key, this.onPressed, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              buttonText.toUpperCase(),
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Selectable extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool selected;

  const Selectable({Key key, this.text, this.onPressed, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //splashColor: Colors.transparent,
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(4.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        elevation: selected ? 8.0 : 4.0,
        color: selected ? Colors.blue : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            text,
            style: TextStyle(
                color: selected ? Colors.white : Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class SelectableColorOrText extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool selected;
  final double fontSize;
  final FontWeight fontWeight;

  const SelectableColorOrText(
      {Key key,
      this.text,
      this.onPressed,
      this.selected = false,
      this.color,
      this.fontSize = 18.0,
      this.fontWeight = FontWeight.w600})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: 100.0,
        width: 100.0,
        margin: const EdgeInsets.all(4.0),
        color: color ?? Colors.white54,
        child: Stack(
          children: <Widget>[
            text == null
                ? SizedBox()
                : Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSize,
                          fontWeight: fontWeight),
                    ),
                  ),
            AnimatedSwitcher(
              transitionBuilder: (Widget child, Animation<double> anim) =>
                  ScaleTransition(
                child: child,
                scale: anim,
              ),
              duration: Duration(milliseconds: 100),
              child: selected
                  ? Center(
                      child: Opacity(
                        opacity: 0.45,
                        child: Icon(
                          Icons.check,
                          size: 64.0,
                        ),
                      ),
                    )
                  : SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
