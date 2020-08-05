import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/services/fcm.dart';
import 'package:doc_connect/services/tip.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/forum/all_forum_view_model.dart';
import 'package:doc_connect/views/profile/select_user_type.dart';
import 'package:doc_connect/views/registration/registration_screen.dart';
import 'package:doc_connect/views/tabs_screen/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class LoginSignUpViewModel extends ChangeNotifier {
  bool _isLogin = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  BuildContext _context;

  instantiate(BuildContext context) {
    _context = context;
  }

  authenticate() {
    if (isLogin)
      _login();
    else
      _register();
  }

  void _login() async {
    /// Todo: Something is fetching duplicate no. of times check it
    showLoader(isModal: true);
    final Response response =
        await AuthService.login(emailController.text, passwordController.text);
    hideLoader();
    if (response.isSuccessful) {
//      LocalDB()..init();

      final decodedJson = json.decode(response.body);
      final user = User.fromJSON(decodedJson["user"]);

      Provider.of<UsersService>(_context, listen: false)
          .parseUserDocPatients(decodedJson);

      Provider.of<TipService>(_context, listen: false).parseTips(decodedJson);

      AllForumViewModel()..fetchForums(_context);
      _updateFCMId();

      if (user.firstName == null ||
          user.firstName.length == 0 ||
          user.gender == null) {
        AuthService.parseHeadersAndStoreAuthData(response, false);
        Navigator.of(_context)
            .pushReplacement(AppNavigation.route(SelectUserType()));
      } else {
        AuthService.parseHeadersAndStoreAuthData(response, user.isDoctor);
        Navigator.of(_context)
            .pushReplacement(AppNavigation.route(TabsScreen()));
      }
    } else {
      final decodedJson = json.decode(response.error);
      AppToast.showLong(text: decodedJson["message"]);
    }
  }

  void _updateFCMId() {
    try {
      FCMService()..createInstanceId();
    } catch (err) {
      throw err;
    }
  }

  void _register() async {
    showLoader(isModal: true);
    final Response response = await AuthService.register(
        emailController.text, passwordController.text);
    hideLoader();
    if (response.isSuccessful) {
      final decodedJson = json.decode(response.body);
      AppToast.showLong(text: decodedJson["message"]);
      emailController.clear();
      passwordController.clear();
      isLogin = true;
    } else {
      final decodedJson = json.decode(response.error);
      AppToast.showLong(text: decodedJson["message"]);
    }
  }

  goToRegistrationScreen() {
    Navigator.of(_context).pushReplacement(
      AppNavigation.route(
        RegistrationScreen(),
      ),
    );
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }
}
