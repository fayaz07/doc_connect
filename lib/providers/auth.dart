import 'package:doc_connect/data_models/auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Auth _auth = Auth();

  Auth get auth => _auth;

  set auth(Auth value) {
    _auth = value;
    notifyListeners();
  }
}
