import 'package:covid19doc/data_models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefConstants {
  static const String email = 'email';
  static const String authToken = 'auth-token';
  static const String refreshToken = 'refresh-token';
  static const String message = 'message';
  static const String status = 'status';
  static const String is_doctor = 'is_doctor';
  static const String loggedIn = 'loggedIn';
}

class Session {
  static SharedPreferences _sharedPrefs;

  /// Call this method during the startup of application
  /// This will get the details from sharedPrefs
  /// Based on the details we will take care of handling the user
  static Future<Auth> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();

    Auth auth = getAuthDetails();

    if (auth.email == null ||
        auth.authToken == null ||
        auth.refreshToken == null)
      auth.loggedIn = false;
    else
      auth.loggedIn = true;

    return auth;
  }

  /// Call this method after successful login of user
  /// so as to have cached copy of user-auth
  static void storeLoginDetails(Auth auth) {
    _sharedPrefs.setString(SharedPrefConstants.email, auth.email);
    _sharedPrefs.setString(SharedPrefConstants.authToken, auth.authToken);
    _sharedPrefs.setString(SharedPrefConstants.refreshToken, auth.refreshToken);
    _sharedPrefs.setBool(SharedPrefConstants.loggedIn, auth.loggedIn);
    _sharedPrefs.setBool(SharedPrefConstants.is_doctor, auth.isDoctor);
  }

  static Auth getAuthDetails() {
    return Auth(
        email: _sharedPrefs.getString(SharedPrefConstants.email),
        authToken: _sharedPrefs.getString(SharedPrefConstants.authToken),
        refreshToken: _sharedPrefs.getString(SharedPrefConstants.refreshToken),
        isDoctor: _sharedPrefs.getBool(SharedPrefConstants.is_doctor),
        loggedIn: _sharedPrefs.getBool(SharedPrefConstants.loggedIn));
  }

  static Future<bool> setAuthToken(String token) async {
    return await _sharedPrefs.setString(SharedPrefConstants.authToken, token);
  }

  static Future<bool> setRefreshToken(String token) async {
    return await _sharedPrefs.setString(
        SharedPrefConstants.refreshToken, token);
  }

  static String getAuthToken() {
    return _sharedPrefs.getString(SharedPrefConstants.authToken);
  }

  static String getRefreshToken() {
    return _sharedPrefs.getString(SharedPrefConstants.refreshToken);
  }

  /// Call this method in case of expired authToken
  /// > uses the refreshToken from sharedPrefs and gets a new authToken
  /// >
//  static Future<String> updateAuthToken() async {
//    String refreshToken =
//    _sharedPrefs.getString(SharedPrefConstants.refreshToken);
//    Result result = await AuthAPI.authToken(refreshToken);
//
//    if (result.success) {
//      Auth auth = result.data;
//      await putSharedPref(SharedPrefConstants.authToken, auth.authToken);
//      return auth.authToken;
//    } else {
//      return null;
//    }
//  }

  /// putSharedPref
  static Future<bool> putSharedPref(String key, dynamic value) async {
    switch (value.runtimeType) {
      case bool:
        return await _sharedPrefs.setBool(key, value);
        break;
      case String:
        return await _sharedPrefs.setString(key, value);
        break;
      case double:
        return await _sharedPrefs.setDouble(key, value);
        break;
      case int:
        return await _sharedPrefs.setInt(key, value);
        break;
      case List:
        return await _sharedPrefs.setStringList(key, value);
        break;
      default:
        return await _sharedPrefs.setString(key, value);
        break;
    }
  }

  /// getSharedPref
  static dynamic getSharedPref(String key, String value) {
    return _sharedPrefs.get(key);
  }

  static Future<bool> logout() async {
    return await _sharedPrefs.clear();
  }
}
