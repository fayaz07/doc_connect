import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String message;

  const DescriptionText({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
            top: Constants.fourBy1,
            left: Constants.sixteenBy3,
            right: Constants.sixteenBy3,
            bottom: Constants.sixteenBy3),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
