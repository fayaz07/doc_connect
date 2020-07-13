import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/views/profile/guest_profile_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class GuestProfile extends StatelessWidget {
  final String userId;
  final bool isDoctor;

  const GuestProfile({Key key, this.userId, this.isDoctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final user = isDoctor
        ? usersProvider.doctors[userId]
        : usersProvider.patients[userId];

    return ViewModelBuilder<GuestProfileViewModel>.reactive(
      onModelReady: (m) => m.init(context),
      viewModelBuilder: () => GuestProfileViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Profile',
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
                getDPAndBaseDetails(user),
                SizedBox(height: 8.0),
                user.isDoctor
                    ? Row(
                        children: <Widget>[
                          RaisedButton(
                            color: user.availableForChat
                                ? Colors.green
                                : Colors.red,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 50.0,
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
                            onPressed: () {
                              if (user.availableForChat) {
                                print('lets chat');
                              } else {
                                print('not available');
                              }
                            },
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
                            color: !user.availableForCall
                                ? Colors.green
                                : Colors.red,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 50.0,
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
                            onPressed: () {
                              if (user.availableForCall) {
                                print('lets call');
                              } else {
                                print('not available');
                              }
                            },
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDPAndBaseDetails(User user) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 40.0,
          backgroundImage: CachedNetworkImageProvider(
            user.photoUrl ?? Constants.defaultProfilePic,
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
