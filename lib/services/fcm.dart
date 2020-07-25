import 'dart:convert';

import 'package:doc_connect/services/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FCMService {
  static bool _initialized = false;
  static final firebaseMessaging = FirebaseMessaging();

  // call this method only once after login
  Future<void> createInstanceId() async {
    firebaseMessaging.autoInitEnabled().then((value) {
      if (!value) {
        firebaseMessaging.setAutoInitEnabled(true);
      }
    });
    final token = await firebaseMessaging.getToken();
    APIService.api.updateFCMId(jsonEncode({"fcm_id": token}));
    init();
  }

  static void init() {
    if (!_initialized) {
      _initialized = true;
      debugPrint("Initialising FCM");
      firebaseMessaging.configure(
        onBackgroundMessage: _onBackgroundMessage,
        onLaunch: _onLaunch,
        onMessage: _onMessage,
        onResume: _onResume,
      );
    }
  }

  static Future<dynamic> _onBackgroundMessage(Map<String, dynamic> message) {
    print("_onBackgroundMessage");
    print(message);
    return Future.value(message);
  }

  static Future<dynamic> _onLaunch(Map<String, dynamic> message) {
    print("_onLaunch");
    print(message);
    return Future.value(message);
  }

  static Future<dynamic> _onMessage(Map<String, dynamic> message) {
    print("_onMessage");
    print(message);
    return Future.value(message);
  }

  static Future<dynamic> _onResume(Map<String, dynamic> message) {
    print("_onResume");
    print(message);
    return Future.value(message);
  }
}
