import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/response/oauth.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/fcm.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:doc_connect/services/tip.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/profile/select_user_type.dart';
import 'package:doc_connect/views/registration/login_sign_up.dart';
import 'package:doc_connect/views/tabs_screen/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class RegistrationViewModel extends ChangeNotifier {
  BuildContext _context;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  final _facebookLogin = FacebookLogin();

  instantiate(BuildContext context) {
    _context = context;
  }

  navigateToLoginSignUpScreen() {
    Navigator.of(_context)
        .pushReplacement(AppNavigation.route(LoginSignUpScreen()));
  }

  loginWithFB() async {
    showLoader(isModal: true);
    final facebookLoginResult = await _facebookLogin.logIn(['email']);
    final token = facebookLoginResult.accessToken.token;
    final Response response = await AuthService.fbAuth(token);
    _handleOAuthResponse(response);
  }

  loginWithGoogle() async {
    showLoader(isModal: true);
    final GoogleSignInAccount signInAccount = await _googleSignIn.signIn();

    final GoogleSignInAuthentication authentication =
        await signInAccount.authentication;

    final Response response = await AuthService.googleAuth(
        authentication.accessToken,
        signInAccount.displayName,
        signInAccount.photoUrl);
    _handleOAuthResponse(response);
  }

  _handleOAuthResponse(Response response) async {
    final OAuthResponse oAuthResponse =
        await compute(OAuthResponse.fromJSON, json.decode(response.body));
    hideLoader();
    if (oAuthResponse.success) {
      _updateFCMId();
      // todo: fetch nearby doctors/patients
      Provider.of<UsersService>(_context, listen: false).user =
          oAuthResponse.user;
      AuthService.parseHeadersAndStoreAuthData(
          response, oAuthResponse.user.isDoctor);

      final Response dashboardResponse = await APIService.api.getDashboard();
      if (dashboardResponse.isSuccessful) {
        AuthService.parseAndStoreHeaders(response);
        final decodedJson = json.decode(response.body);
        Provider.of<UsersService>(_context, listen: false)
            .parseUserDocPatientsData(decodedJson);
        Provider.of<ForumsService>(_context, listen: false)
            .parseForumQuestions(decodedJson);
        Provider.of<TipService>(_context, listen: false).parseTips(decodedJson);

        // init local db
        LocalDB()..init();

        Navigator.of(_context).pushReplacement(AppNavigation.route(
            oAuthResponse.signup ? SelectUserType() : TabsScreen()));

        return;
      } else {
        AppToast.showError(response);
      }
    } else {
      AppToast.showLong(text: oAuthResponse.message);
    }
  }

  void _updateFCMId() {
    try {
      FCMService()..createInstanceId();
    } catch (err) {
      throw err;
    }
  }

  /// getters and setters
}
