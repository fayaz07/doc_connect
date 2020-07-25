import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/profile/guest_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorWidget extends StatelessWidget {
  final String doctorId;
  final int i;

  const DoctorWidget({Key key, this.doctorId, this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctor = Provider.of<UsersProvider>(context).doctors[doctorId];

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          AppNavigation.route(
            GuestProfile(
              userId: doctorId,
              isDoctor: true,
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      child: Container(
        height: 150.0,
        width: 110.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.cardColors[i % 28],
        ),
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.fromLTRB(0.0, 4.0, 6.0, 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              transitionOnUserGestures: true,
              tag: 'pd-hero',
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider(
                  doctor.photoUrl ?? Constants.defaultProfilePic,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${doctor.firstName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${doctor.speciality}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${doctor.location}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
