import 'package:doc_connect/api/auth.dart';
import 'package:doc_connect/screens/login_signup/login.dart';
import 'package:doc_connect/screens/login_signup/signup.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class WhoAreYou extends StatefulWidget {
  @override
  _WhoAreYouState createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        handleGoBack: () {
          Navigator.of(context).pop();
        },
        title: 'Get Started',
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Create an account',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.0),
            Text(
              'I am a',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),
            _getButtons(),
            SizedBox(height: 8.0),
            Text(
              'or',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            FlatButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(AppNavigation.route(Login()));
              },
              child: Text(
                'Login',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PictureButton(
          image: 'assets/doctor.png',
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(AppNavigation.route(SignUp(doctor: true)));
          },
          text: 'Doctor',
        ),
        PictureButton(
          image: 'assets/patient.png',
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(AppNavigation.route(SignUp(doctor: false)));
          },
          text: 'Patient',
        ),
      ],
    );
  }
}


