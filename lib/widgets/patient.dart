import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/profile/guest_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientWidget extends StatelessWidget {
  final String patientId;
  final int i;

  const PatientWidget({Key key, this.patientId, this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<UsersProvider>(context).patients[patientId];

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          AppNavigation.route(
            GuestProfile(
              userId: patientId,
              isDoctor: false,
            ),
          ),
        );
      },
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
              tag: 'pd-hero',
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: CachedNetworkImageProvider(
                  patient.photoUrl ?? Constants.defaultProfilePic,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${patient.firstName}',
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
                    '${patient.symptoms}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
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
                    'Age: ${patient.age} ${patient.gender}',
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
