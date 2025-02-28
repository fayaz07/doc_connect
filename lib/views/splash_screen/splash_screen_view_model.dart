import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/auth.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/services/fcm.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/intro_screens/intro_screen.dart';
import 'package:doc_connect/views/tabs_screen/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SplashScreenViewModel extends ChangeNotifier {
  BuildContext _context;

  bool _checkedAuth = false;

  Future<void> instantiate(BuildContext context) async {
    _context = context;
    if (!_checkedAuth) {
      _checkedAuth = true;

      Auth auth = await AuthService.getAuthData();

      /// todo: locally handle token expiration and refreshing the token
      /// fetching it on dashboard

      if (auth.authToken.length > 10 && auth.refreshToken.length > 10) {
        /// logged in
        debugPrint("User logged in");

        /// init FCM
        FCMService.init();

        final Response response = await APIService.api.getDashboard();
        if (response.isSuccessful) {
          AuthService.parseAndStoreHeaders(response);
          final decodedJson = json.decode(response.body);
          Provider.of<UsersProvider>(_context, listen: false)
              .parseUserDocPatientsData(decodedJson);
          Provider.of<ForumsProvider>(_context, listen: false)
              .parseForumQuestions(decodedJson);
          _navigateToTabsScreen();
          return;
        } else {
          AppToast.showError(response);
        }
      } else {
        /// not logged in
        debugPrint("User not logged in");
        _navigateToIntroScreen();
      }
    }
  }

  void _navigateToIntroScreen() {
    Navigator.of(_context).pushReplacement(AppNavigation.route(IntroScreens()));
  }

  void _navigateToTabsScreen() {
    Navigator.of(_context).pushReplacement(AppNavigation.route(TabsScreen()));
  }
}
