import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GetAvatar extends StatelessWidget {
  final String photoUrl;
  final String firstName;
  final double height;
  final double width;

  const GetAvatar(
      {Key key,
      this.photoUrl,
      this.height = 36.0,
      this.width = 36.0,
      this.firstName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        clipBehavior: Clip.antiAlias,
        type: MaterialType.circle,
        color: Colors.greenAccent,
        child: photoUrl == null
            ? Center(
                child: Text(
                  '${firstName?.substring(0, 1) ?? 'A'}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: photoUrl,
                fadeInCurve: Curves.easeIn,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
