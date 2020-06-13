import 'package:doc_connect/api/auth.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/platform_widgets.dart';
import 'package:doc_connect/utils/widgets/text_field_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'login.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({Key key, this.email}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with SingleTickerProviderStateMixin {
  bool _enableSubmitButton = false;
  TextEditingController _otpController = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  Animation<double> _scaleAnim;
  AnimationController _scaleController;

  @override
  void initState() {
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnim = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _scaleController, curve: Curves.linear));
    super.initState();
    _otpController.addListener(_listenToOTP);
    _newPassword.addListener(_listenToNewPassword);
    _confirmPassword.addListener(_listenToConfirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: 'Reset Password',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),

            /// Enter the OTP
            getTitle('Please enter the OTP you have recieved in your email'),
            Align(
              alignment: Alignment.center,
              child: WrappedTextFieldWithCard(
                controller: _otpController,
                label: "Enter OTP",
                maxLength: 6,
              ),
            ),

            /// Enter new password here
            /// this will be shown, when the otp is valid, i.e., 6 digits
            SizeTransition(
              sizeFactor: _scaleAnim,
              child: _getNewPasswordForm(),
            ),

            SizedBox(height: 32.0),
            Align(
              alignment: Alignment.center,
              child: EnableDisableButton(
                onPressed: _resetPassword,
                text: 'SUBMIT',
                enabled: _enableSubmitButton,
              ),
            ),
            SizedBox(height: 64.0)
          ],
        ),
      ),
    );
  }

  Widget _getNewPasswordForm() {
    return Column(
      children: <Widget>[
        SizedBox(height: 32.0),
        getTitle('Please enter your new password'),
        Align(
          alignment: Alignment.center,
          child: WrappedTextFieldWithCard(
            controller: _newPassword,
            label: "New password",
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: WrappedTextFieldWithCard(
            controller: _confirmPassword,
            label: "Confirm password",
            isObscure: true,
          ),
        )
      ],
    );
  }

  Widget getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          Spacer(flex: 1),
          Expanded(
            flex: 10,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }

  _listenToOTP() {
    if (_otpController.text.length == 6) {
      if (_scaleController.status != AnimationStatus.completed)
        _scaleController.forward();
      setState(() {
        _enableSubmitButton = true;
      });
    } else {
      _scaleController.reverse();
      setState(() {
        _enableSubmitButton = false;
      });
    }
  }

  _listenToNewPassword() {}

  _listenToConfirmPassword() {}

  _resetPassword() async {
    FocusScope.of(context).requestFocus(FocusNode());
    String _newPasswd = _newPassword.text;
    String _confirmPasswd = _confirmPassword.text;

    if (_newPasswd.length > 6 &&
        _confirmPasswd.length > 6 &&
        _newPasswd.trim() == _confirmPasswd.trim()) {
      /// showing loader
//      setState(() {
//        _isLoading = true;
//      });
      showLoader(isModal: true);
      Result result = await AuthAPI.resetPassword(
          email: widget.email,
          newPassword: _newPasswd.trim(),
          otp: _otpController.text.trim());
      if (result.success) {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            title: 'Success',
            content:
                'Your password has been reset, please login with your new password',
            buttonText: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacement(AppNavigation.route(Login()));
            },
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            title: 'Failed',
            content: result.message,
            buttonText: 'OK',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      }

      /// hiding loader
      hideLoader();
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          title: 'Oops',
          content: 'Passwords does\'t match or invalid',
          buttonText: 'RETRY',
        ),
      );
    }
  }
}
