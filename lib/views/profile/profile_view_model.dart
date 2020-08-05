import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/home/home.dart';
import 'package:doc_connect/views/profile/setup_profile_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  final Location _location = Location();
  int _genderKey = -1;
  BuildContext _context;
  final formKey = GlobalKey<FormState>();

  init(BuildContext context) {
    _context = context;
  }

  Future<void> validateDetails() async {
    if (!formKey.currentState.validate()) {
      AppToast.show(text: 'Please enter valid details');
      return;
    }
    showLoader(isModal: true);
    formKey.currentState.save();
    Provider.of<UsersService>(_context, listen: false).user.gender =
        _getGender();
    UsersService()
      ..saveDetails().whenComplete(() {
        _navigateToHomeScreen();
      });
  }

  String _getGender() {
    switch (genderKey) {
      case 0:
        return "Male";
      case 1:
        return "Female";
      case 2:
        return "Private";
    }
    return "Private";
  }

  void handleGenderSelection(int value) {
    genderKey = value;
  }

  Future<void> fetchLocation() async {
    showLoader();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        AppToast.showLong(text: 'Location services disabled');
        hideLoader();
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        AppToast.showLong(text: 'Location permissions denied');
        hideLoader();
        return;
      }
    }
    hideLoader();
    _locationData = await _location.getLocation();
    Provider
        .of<UsersService>(_context, listen: false)
        .user
        .latitude =
        _locationData.latitude;
    Provider
        .of<UsersService>(_context, listen: false)
        .user
        .latitude =
        _locationData.longitude;
    notifyListeners();
  }

  selectDoctor(bool isDoctor) async {
    showLoader(isModal: true);
    Provider
        .of<UsersService>(_context, listen: false)
        .user
        .isDoctor = isDoctor;
    final Response response = await APIService.api
        .updateUserType(jsonEncode({"is_doctor": isDoctor}));
    hideLoader();
    if (response.isSuccessful) {
      AuthService.storeUserType(isDoctor);
      _navigateToProfileDetailsSetupScreen();
    } else
      AppToast.showLong(text: json.decode(response.body)["message"]);
  }

  void uploadProfilePicture() {
    AppToast.show(text: "Uploading profile picture is not configured yet");
  }

  /// Navigation logic
  _navigateToProfileDetailsSetupScreen() {
    Navigator.of(_context)
        .pushReplacement(AppNavigation.route(SetupProfileDetails()));
  }

  _navigateToHomeScreen() {
    Navigator.of(_context).pushReplacement(AppNavigation.route(HomeScreen()));
  }

  pop() {
    Navigator.of(_context).pop();
  }

  User get user =>
      _context != null
          ? Provider
          .of<UsersService>(_context, listen: false)
          .user
          : User();

  set user(User user) {
    Provider
        .of<UsersService>(_context, listen: false)
        .user = user;
  }

  /// getters and setters
  int get genderKey => _genderKey;

  set genderKey(int value) {
    _genderKey = value;
    notifyListeners();
  }
}
