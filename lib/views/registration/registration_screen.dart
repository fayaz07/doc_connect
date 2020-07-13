import 'package:doc_connect/views/registration/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      viewModelBuilder: () => RegistrationViewModel(),
      onModelReady: (m) => m.instantiate(context),
      builder: (context, model, child) => PlatformScaffold(
//      backgroundColor: Theme.of(context).backgroundColor,
        backgroundColor: isDarkTheme ? Colors.black : Colors.greenAccent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // a small gap
                SizedBox(height: 16.0),
                // here goes our logo
                _getLogo(size),
                // a little more gap
                SizedBox(height: 32.0),
                // introduction to the user
                _getIntroText(),
                // a little more gap
                SizedBox(height: 64.0),
                _getSocialButtons(model),
                // a little gap
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'By continuing you accept to our',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      'Terms of use',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSocialButtons(RegistrationViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SocialButton(
          onPressed: model.loginWithGoogle,
          asset: 'assets/google.png',
        ),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: model.loginWithFB,
          asset: 'assets/facebook.png',
        ),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: () {
            model.navigateToLoginSignUpScreen();
          },
          asset: 'assets/mail.png',
        ),
        Spacer(flex: 1),
      ],
    );
  }

//  Widget _loginSignUpForm(RegistrationViewModel model) => StreamBuilder<bool>(
//      stream: _formStatusController.stream,
//      initialData: true,
//      builder: (context, snapshot) {
//        return ;
//      });

  Widget _getIntroText() => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hi 👋\nWe\'re glad you are here\n',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '\nChoose any mode for login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            TextSpan(
              text: '\nWe never share our user\'s data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      );

  Widget _getLogo(Size size) => SizedBox(
        height: size.height * .16,
        child: FlutterLogo(
          size: size.height * .16,
        ),
      );
}

class SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const SocialButton({Key key, this.asset, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
      child: CircleAvatar(
        radius: 26,
//        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(asset),
      ),
    );
  }
}
