import 'package:covid19doc/api/dashboard.dart';
import 'package:covid19doc/api/utils/logger.dart';
import 'package:covid19doc/data_models/auth.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/providers/auth.dart';
import 'package:covid19doc/providers/doctor_data.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/providers/patient_data.dart';
import 'package:covid19doc/providers/session.dart';
import 'package:covid19doc/providers/user.dart';
import 'package:covid19doc/screens/doctor/doctor_home.dart';
import 'package:covid19doc/screens/login_signup/login.dart';
import 'package:covid19doc/screens/login_signup/who_are_you.dart';
import 'package:covid19doc/screens/patients/patient_home.dart';
import 'package:covid19doc/utils/dialogs/dialogs.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

/*
 *  Splash screen is shown until the app is initialized and based on user login status, app
 *  will navigate the user to relevant screens
 *  App initialization includes Firebase Initialization and getting current logged in user's details
 */

class SplashScreen extends StatelessWidget {
  initializeApp(context) {
    Log.info('Initialising application');
    Session.init().then((Auth auth) async {
      Log.info('User loggedin: $auth');

      /// User not logged in
      if (!auth.loggedIn) {
        /// new user
        Navigator.of(context).pushReplacement(AppNavigation.route(WhoAreYou()));
        return;
      }

      /// user is logged in, so fetching dashboard data

      Log.info('Getting user dashboard from server');

      Provider.of<AuthProvider>(context, listen: false).auth = auth;

      Result result = await DashboardAPI.getDashboard();
      if (result.success) {
        Provider.of<UserProvider>(context, listen: false).user =
            result.data['user'];

        Provider.of<ForumsProvider>(context, listen: false).forums =
            result.data['forums'];

        if (Provider.of<UserProvider>(context, listen: false).user.is_doctor) {
          Provider.of<DoctorDataProvider>(context, listen: false)
              .nearbyPatients = result.data['patients'];
          Navigator.of(context)
              .pushReplacement(AppNavigation.route(DoctorHome()));
        } else {
          Provider.of<PatientDataProvider>(context, listen: false)
              .nearbyDoctors = result.data['doctors'];
          Navigator.of(context)
              .pushReplacement(AppNavigation.route(PatientHome()));
        }
        return;
      } else {
        /// some other issue
        showDialog(
          context: context,
          builder: (context) => WarningDialog(
            title: 'Oops',
            buttonText: 'LOGIN',
            content:
                'You might have logged out of the application, please login to continue',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacement(AppNavigation.route(Login()));
            },
          ),
        );
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeApp(context);

    // Showing the logo just as shown from Native Android side
    // Image dimensions shown on Native Android are also 200x200
    return Scaffold(
      body: Center(
//        child: Image.asset(
//          Assets.logo512x512,
//          height: 200.0,
//          width: 200.0,
//        ),
        child: FlutterLogo(
          size: 128.0,
        ),
      ),
    );
  }
}
