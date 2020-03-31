import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ProfileDetailTile extends StatelessWidget {
  final String title, data;

  const ProfileDetailTile({Key key, @required this.title, @required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          Text(
            data,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
