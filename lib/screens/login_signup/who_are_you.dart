import 'package:covid19doc/screens/login_signup/signup.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WhoAreYou extends StatefulWidget {
  @override
  _WhoAreYouState createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'I am a',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 16.0),
            _getButtons(),
          ],
        ),
      ),
    );
  }

  Widget _getButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        PictureButton(
          image: 'assets/doctor.png',
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(AppNavigation.route(SignUp(doctor: true)));
          },
          text: 'Doctor',
        ),
        PictureButton(
          image: 'assets/patient.png',
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(AppNavigation.route(SignUp(doctor: false)));
          },
          text: 'Patient',
        ),
      ],
    );
  }
}

class PictureButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final String text;

  const PictureButton({Key key, this.image, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: MediaQuery.of(context).size.width * 0.2,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.2 - 4.0,
              backgroundImage: AssetImage(image),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
