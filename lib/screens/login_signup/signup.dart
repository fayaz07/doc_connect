import 'package:covid19doc/api/auth.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/utils/colors.dart';
import 'package:covid19doc/utils/dialogs/dialogs.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/login_signup_widgets.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:covid19doc/utils/widgets/platform_widgets.dart';

import 'package:covid19doc/utils/widgets/text_field_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/constants.dart';
import '../../utils/labels.dart';
import '../base_view.dart';
import 'login.dart';

RegExp passwordRegex =
    RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

class SignUp extends StatefulWidget {
  final bool doctor;

  const SignUp({Key key, this.doctor}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  bool _isValidEmail = false, _isValidPassword = false, _showModal = false;

  bool _showPasswordField = false;

  String _email, _password;

  String status = " ";

  bool _passwordShown = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _validateEmail() {
    _email = _emailController.text;
    if (_email.length > 3 &&
        _email.contains("@") &&
        _email.contains(".") &&
        !_isValidEmail) {
      setState(() {
        _isValidEmail = true;
        _showPasswordField = true;
      });
    }
    if (_isValidEmail && !_email.contains("@") || !_email.contains(".")) {
      setState(() {
        _isValidEmail = false;
      });
    }
  }

  void _validatePassword() {
    _password = _passwordController.text;
    if (!_isValidPassword) {
//      if (passwordRegex.hasMatch(_password)) {
//        setState(() {
//          _isValidPassword = true;
//          _rotationAnimController2.forward();
//        });
//      }
      if (_password.length >= 6) {
        setState(() {
          _isValidPassword = true;
        });
      }
    } else {
      if (_password.length <= 6) {
        setState(() {
          _isValidPassword = false;
        });
      }
//      if (!passwordRegex.hasMatch(_password)) {
//        setState(() {
//          _isValidPassword = false;
//          _rotationAnimController.reverse();
//        });
//      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _passwordController.removeListener(_validatePassword);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);

    return Scaffold(
      appBar: _getAppBar(),
      body: BaseView(
        isModal: true,
        showLoader: _showModal,
        child: SafeArea(
          child: SingleChildScrollView(child: _emailAndPasswordForm()),
        ),
      ),
    );
  }

  Widget _emailAndPasswordForm() => Column(
        key: Key('email-screen'),
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: Constants.sixteenBy3),
            child: Align(
              alignment: Alignment.center,
//            child: Image.asset(
//              Assets.logo,
//              height: Constants.sixteenBy3,
//            ),
              child: FlutterLogo(
                size: 128.0,
              ),
            ),
          ),

          //  Title
          TitleMessage(title: Labels.createYourAccount),

          SizedBox(height: 32.0),
          //  Enter email field
          WrapTextFieldWithCard(
            child: TextFormField(
              maxLines: 1,
              controller: _emailController,
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: Labels.enterEmail,
                suffixIcon: Icon(
                  Icons.check,
                  color: _isValidEmail ? AppColors.primary : Colors.grey,
                ),
              ),
            ),
          ),

          AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: _showPasswordField
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _getPasswordField(),
                  )
                : SizedBox(),
            switchInCurve: Curves.linear,
          ),

          // Blank space
          SizedBox(height: Constants.sixteenBy2),
          //  Button which handles navigation after validating the entered email
          EnableDisableButton(
            text: Labels.signUp,
            enabled: _isValidPassword && _isValidEmail,
            onPressed: _register,
          ),

          SizedBox(height: 16.0),
          //  Privacy policy
          LinkToLoginScreen(),
        ],
      );

  _register() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await _showModalSheet();
    Result result = await AuthAPI.register(
      email: _email.trim(),
      password: _password.trim(),
      doctor: widget.doctor,
    );
    if (result.success) {
      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Registration success',
          content: result.message,
          actions: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
//              FlatButton(
//                child: Text('OPEN MAILBOX'),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                  openEmailApp(context);
//                  Navigator.of(context)
//                      .pushReplacement(AppNavigation.route(Login()));
//                },
//              ),
              FlatButton(
                child: Text('DONE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacement(AppNavigation.route(Login()));
                },
              ),
            ],
          ),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                title: 'Registration failure',
                content: result.message,
              ));
    }
    await _hideModalSheet();
  }

  void openEmailApp(BuildContext context) {
    try {
//      AppAvailability.launchApp(
//              Platform.isIOS ? "message://" : "com.google.android.gm")
//          .then((_) {
//        print("App Email launched!");
//      }).catchError((err) {
//        Scaffold.of(context)
//            .showSnackBar(SnackBar(content: Text("App Email not found!")));
//        print(err);
//      });
    } catch (e) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Email App not found!")));
    }
  }

  Widget _getPasswordField() => WrapTextFieldWithCard(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: TextFormField(
                maxLines: 1,
                obscureText: !_passwordShown,
                controller: _passwordController,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: Labels.enterPassword,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _passwordShown = !_passwordShown;
                    });
                  },
                  child: Icon(_passwordShown
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash)),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.check,
                color: _isValidPassword ? AppColors.primary : Colors.grey,
              ),
            ),
            SizedBox(width: 5.0)
          ],
        ),
      );

  _showModalSheet() {
    setState(() {
      _showModal = true;
    });
  }

  _hideModalSheet() {
    setState(() {
      _showModal = false;
    });
  }

  _handleGoBack() {
    status = " ";
    Navigator.of(context).pop();
//    Navigator.of(context).pushReplacement(AppNavigation.route(IntroScreens()));
  }

  Widget _getAppBar() => MyAppbar(title: 'Signup', handleGoBack: _handleGoBack);
}
