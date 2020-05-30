import 'package:covid19doc/api/auth.dart';
import 'package:covid19doc/data_models/auth.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/data_models/user.dart';
import 'package:covid19doc/providers/auth.dart';
import 'package:covid19doc/providers/doctor_data.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/providers/patient_data.dart';
import 'package:covid19doc/providers/session.dart';
import 'package:covid19doc/providers/user.dart';
import 'package:covid19doc/screens/doctor/doctor_home.dart';
import 'package:covid19doc/screens/login_signup/password_reset.dart';
import 'package:covid19doc/screens/patients/patient_home.dart';
import 'package:covid19doc/utils/dialogs/dialogs.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/login_signup_widgets.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:covid19doc/utils/widgets/platform_widgets.dart';
import 'package:covid19doc/utils/widgets/text_field_register.dart';
import 'package:covid19doc/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/labels.dart';
import '../base_view.dart';
import 'complete_profile.dart';

class Login extends StatefulWidget {
  final bool isDoctor;

  const Login({Key key, this.isDoctor = false}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _validEmail = false, _validPassword = false, _showModal = false;

  String _email, _password, status = " ";

  void _validateEmail() {
    _email = _emailController.text;
    if (_email.contains("@") && _email.contains(".")) {
      _validEmail = true;
    } else {
      _validEmail = false;
    }
    setState(() {});
  }

  void _validatePassword() {
    _password = _passwordController.text;
    if (_password.length > 5) {
      _validPassword = true;
    } else {
      _validPassword = false;
    }
    setState(() {});
  }

  loginWithFB() async {
    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email']);
    final token = facebookLoginResult.accessToken.token;
    final res = await AuthAPI.fbAuthentication(token, widget.isDoctor);

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
    setState(() {
      _showModal = true;
    });
    _googleSignIn.signIn().then((GoogleSignInAccount acc) {

      acc.authentication.then((GoogleSignInAuthentication a) async {
//        print(a.accessToken);

        a.idToken;
        a.accessToken;

        final res =
            await AuthAPI.googleAuthentication(a.accessToken, widget.isDoctor);

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

    setState(() {
      _showModal = false;
    });
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
          child: SingleChildScrollView(
            child: _getLoginForm(),
          ),
        ),
      ),
      bottomNavigationBar: LinkToRegisterScreen(),
    );
  }

  _sendPasswordResetEmail() async {
    FocusScope.of(context).requestFocus(FocusNode());
    String email = _emailController.text.trim();
    if (email.contains("@") && _validEmail) {
      await _showModalSheet();
      Result result = await AuthAPI.forgotPassword(email);
      await _hideModalSheet();
      if (result.success) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            title: 'Email sent!',
            content:
                'You will recieve an email with a 6 digit code, please enter it here to reset your password',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  AppNavigation.route(ResetPassword(email: email)));
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            title: 'Oops',
            content: 'Something has gone wrong, please try later',
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: 'Invalid email',
          content: 'Please enter a valid email to continue',
        ),
      );
    }
  }

  _tryLogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    await _showModalSheet();
    Result result =
        await AuthAPI.login(email: _email.trim(), password: _password.trim());
    await _hideModalSheet();
    if (result.success) {
      Auth authData = result.data['auth'];

      Provider.of<AuthProvider>(context, listen: false).auth = authData;
      Session.storeLoginDetails(authData);

      Provider.of<ForumsProvider>(context, listen: false).forums =
          result.data['forums'];

      if (authData.isDoctor) {
        Provider.of<DoctorDataProvider>(context, listen: false).nearbyPatients =
            result.data['patients'];
      } else {
        Provider.of<PatientDataProvider>(context, listen: false).nearbyDoctors =
            result.data['doctors'];
      }

      if (result.data['user'] == null) {
        Navigator.of(context)
            .pushReplacement(AppNavigation.route(FillProfile()));
        return;
      } else {
        Provider.of<UserProvider>(context, listen: false).user =
            result.data['user'];
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
        builder: (context) => ErrorDialog(
          title: 'Login failed',
          content: result.message,
        ),
      );
    }
  }

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

  Widget _getAppBar() => MyAppbar(
        handleGoBack: _handleGoBack,
        title: 'Login',
      );

  _handleGoBack() {
    status = " ";
    Navigator.of(context).pop();
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

  Widget _getLoginForm() {
    return Column(
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
        TitleMessage(title: Labels.welcomeBack),
        SizedBox(height: Constants.sixteenBy3),
        WrapTextFieldWithCard(
          child: TextFormField(
            maxLines: 1,
            controller: _emailController,
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: Labels.enterEmail,
            ),
          ),
        ),
        SizedBox(height: Constants.eightBy1),
        WrapTextFieldWithCard(
          child: TextFormField(
            maxLines: 1,
            obscureText: true,
            controller: _passwordController,
            autofocus: false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: Labels.enterPassword,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Constants.sixteenBy1),
          child: Text(status, textAlign: TextAlign.center),
        ),
        EnableDisableButton(
          text: Labels.logIn,
          enabled: _validEmail && _validPassword,
          onPressed: _tryLogin,
        ),
        SizedBox(height: Constants.sixteenBy1),
        //  Forgot password button
        SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Labels.forgotPassword,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              InkWell(
                onTap: _sendPasswordResetEmail,
                child: Text(
                  ' ${Labels.clickHereToReset}',
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                    color: Colors.pink,
                  ),
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 16.0),

        Text(
          'or',
          style: TextStyle(fontSize: 18.0),
        ),

        SizedBox(height: 16.0),
        _getSocialButtons(),
      ],
    );
  }
}
