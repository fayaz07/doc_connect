import 'package:doc_connect/providers/auth.dart';
import 'package:doc_connect/providers/chat.dart';
import 'package:doc_connect/providers/current_forum_data.dart';
import 'package:doc_connect/providers/doctor_data.dart';
import 'package:doc_connect/providers/forums.dart';
import 'package:doc_connect/providers/patient_data.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/login_signup/splash.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
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
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
      ],
      child: OTS(
        showNetworkUpdates: true,
        child: MaterialApp(
          home: SplashScreen(),
          title: 'Doc Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: AppColors.primary),
        ),
      ),
    );
  }
}
