import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/auth.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _secureStorage = FlutterSecureStorage();

  static Auth authData = Auth();

  static Future<dynamic> register(String email, String password) async {
    return await APIService.api
        .register(jsonEncode({"email": email, "password": password}));
  }

  static Future<dynamic> fbAuth(String token) async {
    return await APIService.api.fbAuth(jsonEncode({"access_token": token}));
  }

  static Future<dynamic> login(String email, String password) async {
    return await APIService.api
        .login(jsonEncode({"email": email, "password": password}));
  }

  static Future<dynamic> googleAuth(
      String token, String name, String photoUrl) async {
    return await APIService.api.googleAuth(jsonEncode(
        {"access_token": token, "name": name, "photo_url": photoUrl}));
  }

  static Future<void> parseHeadersAndStoreAuthData(
      Response response, bool isDoctor) async {
    authData.userType = isDoctor ? UserType.Doctor : UserType.Patient;
    authData.authToken = response.headers[Constants.authToken];
    authData.refreshToken = response.headers[Constants.refreshToken];
    await _storeAuthData(authData);
  }

  static Future<void> parseAndStoreHeaders(Response response) async {
    authData.authToken = response.headers[Constants.authToken];
    authData.refreshToken = response.headers[Constants.refreshToken];
    await _secureStorage.write(
        key: Constants.authToken, value: authData.authToken);
    await _secureStorage.write(
        key: Constants.refreshToken, value: authData.refreshToken);
  }

  static Future<void> storeTokens(String authToken, String refreshToken) async {
    authData.authToken = authToken;
    authData.refreshToken = refreshToken;
    await _secureStorage.write(
        key: Constants.authToken, value: authData.authToken);
    await _secureStorage.write(
        key: Constants.refreshToken, value: authData.refreshToken);
    print("stroed");
  }

  static Future<void> storeUserType(bool isDoctor) async {
    authData.userType = isDoctor ? UserType.Doctor : UserType.Patient;
    await _secureStorage.write(
        key: Constants.userType, value: authData.userType.value());
  }

  static Future<void> _storeAuthData(Auth auth) async {
    try {
      authData = auth;
      await _secureStorage.write(
          key: Constants.authToken, value: auth.authToken);
      await _secureStorage.write(
          key: Constants.refreshToken, value: auth.refreshToken);
      await _secureStorage.write(
          key: Constants.userType, value: auth.userType.value());
    } catch (err) {
      debugPrint("Issue storing auth data in secure storage");
      throw err;
    }
  }

  static Future<Auth> getAuthData() async {
    try {
      Map<String, String> data = await _secureStorage.readAll();
      authData = Auth(
        authToken: data[Constants.authToken] ?? "",
        refreshToken: data[Constants.refreshToken] ?? "",
        userType: Auth.fromString(data[Constants.userType] ?? ""),
      );
      return authData;
    } catch (err) {
      debugPrint("Issue fetching auth data in AuthService");
      throw err;
    }
  }

  static final timestampKey = "timestamp";

  static Future<void> storeTimestamp(DateTime dateTime) async {
    await _secureStorage.write(
        key: timestampKey, value: dateTime.toIso8601String());
  }

  static Future<DateTime> getTimestamp() async {
    final dateTimeString = await _secureStorage.read(key: timestampKey);
    if (dateTimeString == null) return null;
    final dateTime = DateTime.parse(dateTimeString);
    return dateTime;
  }

  static Future<void> logout() async {
    authData = Auth();
    return await _secureStorage.deleteAll();
  }
}
