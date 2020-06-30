import 'package:doc_connect/data_models/auth.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _secureStorage = FlutterSecureStorage();

  static Future<Auth> getAuthData() async {
    try {
      Map<String, String> data = await _secureStorage.readAll();
      return Auth(
        authToken: data[Constants.authToken] ?? "",
        refreshToken: data[Constants.refreshToken] ?? "",
        userType: Auth.fromString(data[Constants.userType] ?? ""),
      );
    } catch (err) {
      debugPrint("Issue fetching auth data in AuthService");
      throw err;
    }
  }

  static Future<void> logout() async {
    return await _secureStorage.deleteAll();
  }
}
