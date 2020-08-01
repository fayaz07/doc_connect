import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/views/profile/guest_profile_view_model.dart';
import 'package:doc_connect/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:doc_connect/utils/validators.dart';

class GuestProfile extends StatelessWidget {
  final String userId;
  final bool isDoctor;

  const GuestProfile({Key key, this.userId, this.isDoctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final guestUser = isDoctor
        ? usersProvider.doctors[userId]
        : usersProvider.patients[userId];

    return ViewModelBuilder<GuestProfileViewModel>.reactive(
      onModelReady: (m) => m.init(context, guestUser),
      viewModelBuilder: () => GuestProfileViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.pop,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getDPAndBaseDetails(guestUser),
                SizedBox(height: 8.0),
                guestUser.isDoctor
                    ? _getCallAndChatOptions(model, guestUser, context)
                    : SizedBox(),
                SizedBox(height: 16.0),
                _getOfferAppointmentOption(model, guestUser, context),
                SizedBox(height: 16.0),
                TitleText(title: 'Other details'),
                Divider(thickness: 1.5),
                _getProfessionalDetails(model, guestUser)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProfessionalDetails(GuestProfileViewModel model, User guestUser) {
    List<Widget> details = [];
    if (!guestUser.profession.isNull())
      details.add(
        ListTile(
          title: Text('Profession'),
          subtitle: Text(guestUser.profession),
        ),
      );

    if (!guestUser.website.isNull())
      details.add(
        ListTile(
          title: Text('Website'),
          subtitle: Text(guestUser.website),
        ),
      );

    if (guestUser.isDoctor) {
      if (!guestUser.speciality.isNull())
        details.add(
          ListTile(
            title: Text('Speciality'),
            subtitle: Text(guestUser.speciality),
          ),
        );
    } else {
      if (!guestUser.symptoms.isNull())
        details.add(
          ListTile(
            title: Text('Symptoms'),
            subtitle: Text(guestUser.symptoms),
          ),
        );
    }

    if (!guestUser.location.isNull())
      details.add(
        ListTile(
          title: Text('Location'),
          subtitle: Text(guestUser.location),
        ),
      );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: details,
    );
  }

  Widget _getCallAndChatOptions(
      GuestProfileViewModel model, User guestUser, BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          color: guestUser.availableForChat ? Colors.green : Colors.red,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 40.0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Icon(Icons.message, color: Colors.white),
                ],
              ),
            ),
          ),
          onPressed: model.handleChat,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 8.0,
        ),
        SizedBox(
          width: 16.0,
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 8.0,
          color: !guestUser.availableForCall ? Colors.green : Colors.red,
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.35,
            height: 40.0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Call',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Icon(Icons.call, color: Colors.white),
                ],
              ),
            ),
          ),
          onPressed: model.handleCall,
        ),
      ],
    );
  }

  Widget _getOfferAppointmentOption(GuestProfileViewModel model, User guestUser,
      BuildContext context) {
    return RaisedButton(
      color: Colors.lightBlue,
      child: SizedBox(
        width: double.infinity,
        height: 40.0,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${guestUser.isDoctor ? "Request" : "Offer"} appointment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () => model.offerOrApplyForAppointment(guestUser),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8.0,
    );
  }

  Widget getDPAndBaseDetails(User user) {
    return Row(
      children: <Widget>[
        Hero(
          transitionOnUserGestures: true,
          tag: 'pd-hero',
          child: CircleAvatar(
            radius: 40.0,
            backgroundImage: CachedNetworkImageProvider(
              user.photoUrl ?? Constants.defaultProfilePic,
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '${user.age ?? " "} ${user.gender ?? " "}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Text(
                '${user.isDoctor ? "Doctor" : "Patient"}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
