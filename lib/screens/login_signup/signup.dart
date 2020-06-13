import 'package:doc_connect/api/auth.dart';
import 'package:doc_connect/data_models/auth.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/providers/auth.dart';
import 'package:doc_connect/providers/doctor_data.dart';
import 'package:doc_connect/providers/forums.dart';
import 'package:doc_connect/providers/patient_data.dart';
import 'package:doc_connect/providers/session.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/doctor/doctor_home.dart';
import 'package:doc_connect/screens/patients/patient_home.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/login_signup_widgets.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/platform_widgets.dart';

import 'package:doc_connect/utils/widgets/text_field_register.dart';
import 'package:doc_connect/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/labels.dart';
import 'complete_profile.dart';
import 'login.dart';

RegExp passwordRegex =
    RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");

class SignUp extends StatefulWidget {
  final bool doctor;

  const SignUp({Key key, this.doctor = false}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  bool _isValidEmail = false, _isValidPassword = false;

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
      body: SafeArea(
        child: SingleChildScrollView(child: _emailAndPasswordForm()),
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

          Text(
            'or',
            style: TextStyle(fontSize: 18.0),
          ),

          SizedBox(height: 16.0),
          // or
          _getSocialButtons(),

          //  Privacy policy
          LinkToLoginScreen(isDoctor: widget.doctor),
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

  Widget _getSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Spacer(flex: 1),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: loginWithGoogle,
          asset: 'assets/google.png',
        ),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: loginWithFB,
          asset: 'assets/facebook.png',
        ),
        Spacer(flex: 1),
      ],
    );
  }

  loginWithFB() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email']);
    final token = facebookLoginResult.accessToken.token;
    final res = await AuthAPI.fbAuthentication(token, widget.doctor);

//   print(res);
    if (res.success) {
//      if (res.data['signup']) {
//        // navigate to complete profile screen
//
//      }

      Auth authData = res.data['auth'];
      print(authData);

      Provider.of<AuthProvider>(context, listen: false).auth = authData;
      Session.storeLoginDetails(authData);

      Provider.of<ForumsProvider>(context, listen: false).forums =
          res.data['forums'];

//      if (authData.isDoctor) {
      Provider.of<DoctorDataProvider>(context, listen: false).nearbyPatients =
          res.data['patients'];
      //    } else {
      Provider.of<PatientDataProvider>(context, listen: false).nearbyDoctors =
          res.data['doctors'];
      //  }

      if ((res.data['user'] as User).gender == null) {
        Provider.of<UserProvider>(context, listen: false).user =
            res.data['user'];
        Navigator.of(context)
            .pushReplacement(AppNavigation.route(FillProfile()));
        return;
      } else {
        Provider.of<UserProvider>(context, listen: false).user =
            res.data['user'];
        final auth = Provider.of<AuthProvider>(context, listen: false).auth;
        if (auth.isDoctor)
          Navigator.of(context)
              .pushReplacement(AppNavigation.route(DoctorHome()));
        else
          Navigator.of(context)
              .pushReplacement(AppNavigation.route(PatientHome()));
        return;
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog(title: 'Login failed', content: res.message),
      );
    }
  }

  loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    showLoader(isModal: true);
    _googleSignIn.signIn().then((acc) {
      acc.authentication.then((a) async {
//        print(a.accessToken);

        final res =
            await AuthAPI.googleAuthentication(a.accessToken, widget.doctor);

//   print(res);
        if (res.success) {
//      if (res.data['signup']) {
//        // navigate to complete profile screen
//
//      }

          Auth authData = res.data['auth'];
          print(authData);

          Provider.of<AuthProvider>(context, listen: false).auth = authData;
          Session.storeLoginDetails(authData);

          Provider.of<ForumsProvider>(context, listen: false).forums =
              res.data['forums'];

//      if (authData.isDoctor) {
          Provider.of<DoctorDataProvider>(context, listen: false)
              .nearbyPatients = res.data['patients'];
          //    } else {
          Provider.of<PatientDataProvider>(context, listen: false)
              .nearbyDoctors = res.data['doctors'];
          //  }

          if ((res.data['user'] as User).gender == null) {
            Provider.of<UserProvider>(context, listen: false).user =
                res.data['user'];
            Navigator.of(context)
                .pushReplacement(AppNavigation.route(FillProfile()));
            return;
          } else {
            Provider.of<UserProvider>(context, listen: false).user =
                res.data['user'];
            final auth = Provider.of<AuthProvider>(context, listen: false).auth;
            if (auth.isDoctor)
              Navigator.of(context)
                  .pushReplacement(AppNavigation.route(DoctorHome()));
            else
              Navigator.of(context)
                  .pushReplacement(AppNavigation.route(PatientHome()));
            return;
          }
        } else {
          showDialog(
            context: context,
            builder: (context) =>
                ErrorDialog(title: 'Login failed', content: res.message),
          );
        }
      });
    });
    hideLoader();
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
    showLoader();
  }

  _hideModalSheet() {
    hideLoader();
  }

  _handleGoBack() {
    status = " ";
    Navigator.of(context).pop();
//    Navigator.of(context).pushReplacement(AppNavigation.route(IntroScreens()));
  }

  Widget _getAppBar() => MyAppbar(title: 'Signup', handleGoBack: _handleGoBack);
}
