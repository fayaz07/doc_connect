import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/api/utils/urls.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/screens/guest_profile.dart';
import 'package:doc_connect/utils/configs.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserWidget extends StatelessWidget {
  final User user;

  const UserWidget({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 100.0,
      margin:
          const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(AppNavigation.route(GuestProfile(user: user)));
        },
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: (user.photo_url == null || user.photo_url.length < 5)
                  ? Constants.defaultProfilePic
                  : Urls.host + user.photo_url,
              placeholder: (context, data) => Configs.loader,
              height: 80.0,
              width: 80.0,
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 25.0,
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${user.first_name} ${user.last_name}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${user.is_doctor ? user.speciality : user.symptoms}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
