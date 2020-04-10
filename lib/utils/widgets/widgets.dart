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

class SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const SocialButton({Key key, this.asset, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
      child: CircleAvatar(
        radius: 26,
//        foregroundColor: Colors.white,
//        backgroundColor: Colors.white,
        backgroundImage: AssetImage(asset),
      ),
    );
  }
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