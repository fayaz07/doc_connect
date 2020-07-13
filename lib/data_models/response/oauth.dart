import 'package:doc_connect/data_models/user.dart';

class OAuthResponse {
  String message;
  bool success;
  bool signup;
  User user;
  Map<String, User> doctors;
  Map<String, User> patients;

  OAuthResponse(
      {this.message,
      this.success,
      this.signup,
      this.user,
      this.doctors,
      this.patients});

  static OAuthResponse fromJSON(var json) {
    return OAuthResponse(
      success: json['status'].toString().contains("success") ? true : false,
      message: json['message'],
      signup: json['signup'],
      user: User.fromJSON(json['user']),
      doctors: User.fromJSONList(json['doctors']),
      patients: User.fromJSONList(json['patients']),
    );
  }
}
