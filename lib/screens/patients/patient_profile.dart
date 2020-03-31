import 'package:covid19doc/screens/patients/patient_edit_profile.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PatientProfile extends StatefulWidget {
  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Profile',
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(AppNavigation.route(PatientEditProfile()));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
