import 'package:covid19doc/screens/login_signup/login.dart';
import 'package:covid19doc/screens/login_signup/signup.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'navigation.dart';

class LinkToLoginScreen extends StatelessWidget {
  final bool isDoctor;

  const LinkToLoginScreen({Key key, this.isDoctor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Labels.alreadyHaveAnAccount,
            style: TextStyle(fontSize: 16.0),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                AppNavigation.route(
                  Login(isDoctor: isDoctor),
                ),
              );
            },
            child: Text(
              ' ${Labels.logIn}',
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.underline,
                color: AppColors.pink,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LinkToRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            Labels.dontHaveAnAccount,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(AppNavigation.route(SignUp()));
            },
            child: Text(
              ' ${Labels.register}',
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.underline,
                color: AppColors.pink,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TitleMessage extends StatelessWidget {
  final String title;

  const TitleMessage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
            top: Constants.sixteenBy3,
            left: Constants.sixteenBy3,
            right: Constants.sixteenBy3,
            bottom: Constants.fourBy1),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String message;

  const DescriptionText({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
            top: Constants.fourBy1,
            left: Constants.sixteenBy3,
            right: Constants.sixteenBy3,
            bottom: Constants.sixteenBy3),
        child: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
