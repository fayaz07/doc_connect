import 'package:covid19doc/providers/auth.dart';
import 'package:covid19doc/providers/current_forum_data.dart';
import 'package:covid19doc/providers/doctor_data.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/providers/patient_data.dart';
import 'package:covid19doc/providers/user.dart';
import 'package:covid19doc/screens/login_signup/splash.dart';
import 'package:covid19doc/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() => runApp(Covid19Doc());

class Covid19Doc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForumsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentForumData(),
        )
      ],
      child: MaterialApp(
        home: SplashScreen(),
        title: 'Covid 19 Doc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: AppColors.primary),
      ),
    );
  }
}
