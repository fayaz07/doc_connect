import 'package:doc_connect/data_models/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  /// show loader, this is to show when user's profile picture is uploaded
  /// or user data is updated
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  set showLoader(bool value) {
    _showLoader = value;
    notifyListeners();
  }
}
