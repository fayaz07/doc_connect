import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(MaterialApp(
      home: LoginSignUp(),
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
    ));

class LoginSignUp extends StatefulWidget {
  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PlatformScaffold(
//      backgroundColor: Theme.of(context).backgroundColor,
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
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
              _getSocialButtons(),
              // a little gap
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.center,
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
                alignment: Alignment.center,
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
    );
  }

  Widget _getSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Spacer(flex: 1),
        SocialButton(
          onPressed: () {},
          asset: 'assets/google.png',
        ),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: () {},
          asset: 'assets/facebook.png',
        ),
        SizedBox(width: 16.0),
        SocialButton(
          onPressed: () {},
          asset: 'assets/mail.png',
        ),
        Spacer(flex: 1),
      ],
    );
  }

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
