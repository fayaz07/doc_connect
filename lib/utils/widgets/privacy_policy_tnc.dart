import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../labels.dart';
import 'navigation.dart';

class PrivacyPolicyTnC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 32.0),
        Text(Labels.signUpTnCMessage,
            style: TextStyle(fontSize: 14.0, color: Color(0xff8395a6))),
        SizedBox(height: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InkWell(
              onTap: () {
//                Navigator.of(context)
//                    .push(AppNavigation.route(TermsOfService()));
              },
              child: Text(
                Labels.termsOfService,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.pink,
                  fontSize: 14.0,
                ),
              ),
            ),
            Text(' ${Labels.and} ',
                style: TextStyle(fontSize: 14.0, color: Color(0xff8395a6))),
            InkWell(
              onTap: () {
//                Navigator.of(context)
//                    .pushReplacement(AppNavigation.route(PrivacyPolicy()));
              },
              child: Text(
                Labels.privacyPolicy,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.pink),
              ),
            ),
          ],
        )
      ],
    );
  }
}
