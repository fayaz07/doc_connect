import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void show({@required String text}) {
    Fluttertoast.showToast(
        msg: text,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  static void showLong({@required String text}) {
    Fluttertoast.showToast(
        msg: text,
        fontSize: 16.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG);
  }

  static void showError(Response response) {
    showLong(text: json.decode(response.error)["message"]);
  }
}
