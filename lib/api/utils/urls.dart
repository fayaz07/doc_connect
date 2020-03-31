import 'package:covid19doc/providers/session.dart';

class Urls {
//  static const String _baseURL = "http://192.168.43.170:3000/api/v1/";
  static const String _baseURL = "https://covid-19-doc.herokuapp.com/api/v1/";

  static get host => _baseURL.replaceAll("api/v1/", "");

  /// Register and login
  static const String register = _baseURL + "auth/register";
  static const String login = _baseURL + "auth/login";

  /// Refresh token
  static const String token = _baseURL + "auth/token";

  /// forgot password
  static const String forgotPassword = _baseURL + "auth/sendPasswordResetCode";
  static const String resetPassword = _baseURL + "auth/resetPassword";
  static const String changePassword = _baseURL + "auth/changePassword";

  /// TODO: DONE add a button to handle resending of Email verification token it is valid for 1 hour
  static const String resendVerificationToken =
      _baseURL + "auth/resendVerificationToken";

  ///---------------------- dashboard
  static const String dashboard = _baseURL + "dashboard";

  /// --------------------- user
  static const String saveUserDataForFistTime = _baseURL + "user/initial";
  static const String getCurrentUserDetails = _baseURL + "user";
  static const String updateUserPreferences = _baseURL + "user/preferences";
  static const String uploadImage = _baseURL + "user/pp";

  ///-----------------------------Forum-------------------------------------------
  static const String createForum = _baseURL + "forum";

  /// --------------------------- Sockets NSP --------------------------
  static final String forumsNSP = _baseURL.replaceAll("api/v1/", "") + "forums";

  ///-----------------------------------------------------------------------------

  static const defHeaders = {"Content-Type": "application/json"};

  static Map<String, String> getHeadersWithToken() {
    return {
      "Content-Type": "application/json",
      SharedPrefConstants.authToken: Session.getAuthToken()
    };
  }

  static Map<String, String> getHeadersWithRefreshToken() {
    return {
      "Content-Type": "application/json",
      SharedPrefConstants.authToken: Session.getAuthToken(),
      SharedPrefConstants.refreshToken: Session.getRefreshToken(),
    };
  }
}
