import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';

class SnackBarService {
  void showSnackBar({BuildContext context, String message}) {
    Flushbar(
//      title:  "Hey Ninja",
      message: message,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
