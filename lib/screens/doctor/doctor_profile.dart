import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/api/file_upload.dart';
import 'package:doc_connect/api/utils/urls.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/doctor/edit_profile.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatefulWidget {

  const DoctorProfile({Key key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: MyAppbar(
        title: 'Profile',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                AppNavigation.route(
                  EditDoctorProfile(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(child: _getProfileDetails(user)),
    );
  }

  _getProfileDetails(UserProvider userProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () => updateProfilePicture(userProvider),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 79.0,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage: (userProvider.user.photo_url !=
                                      null &&
                                  userProvider.user.photo_url.length > 5)
                              ? CachedNetworkImageProvider(
                                  userProvider.user.photo_url.contains("http")
                                      ? userProvider.user.photo_url
                                      : Urls.host + userProvider.user.photo_url,
                                )
                              : AssetImage('assets/user.png'),
                        ),
                      ),
                      Positioned(
                        bottom: 5.0,
                        right: 15.0,
                        child: Icon(
                          FontAwesomeIcons.camera,
                          size: 32.0,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                // name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      userProvider.user.first_name +
                          ' ' +
                          userProvider.user.last_name,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 8.0),
                    userProvider.user.is_doctor
                        ? Icon(
                            FontAwesomeIcons.solidCheckCircle,
                            color: Colors.blue,
                          )
                        : SizedBox()
                  ],
                ),

                SizedBox(height: 8.0)
              ],
            ),
          ),

          ///-------- end container
          SizedBox(height: 16.0),

          ProfileDetailTile(
            title: 'Speciality',
            data: userProvider.user.speciality ?? '-',
          ),
          ProfileDetailTile(
            title: 'Hospital',
            data: userProvider.user.hospital_name ?? '-',
          ),
          ProfileDetailTile(
            title: 'Availability',
            data: userProvider.user.availability ?? '-',
          ),
          ProfileDetailTile(
            title: 'Website',
            data: userProvider.user.website ?? '-',
          ),
          ProfileDetailTile(
            title: 'Profession',
            data: userProvider.user.profession ?? '-',
          ),
          ProfileDetailTile(
            title: 'Gender',
            data: userProvider.user.gender ?? '-',
          ),
          ProfileDetailTile(
            title: 'Location',
            data: userProvider.user.location ?? '-',
          ),
        ],
      ),
    );
  }

  void updateProfilePicture(UserProvider userProvider) async {
    // update profile picture
    final pp = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pp != null) {
      userProvider.showLoader = true;
      Result result = await FileUpload.uploadUserPP(pp);
      if (result.success) {
        userProvider.user.photo_url = result.data;
        userProvider.user = userProvider.user;
        userProvider.showLoader = false;
      } else {
        showDialog(
          context: context,
          builder: (context) => WarningDialog(
            title: 'Upload failed',
            content: 'Unable to update user picture, please try later',
          ),
        );
      }
    }
  }
}
