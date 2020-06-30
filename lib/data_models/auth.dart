class Auth {
  String authToken;
  String refreshToken;
  UserType userType;

  Auth({this.authToken, this.refreshToken, this.userType});

  static UserType fromString(String key) {
    if (key.contains("Doctor"))
      return UserType.Doctor;
    else
      return UserType.Patient;
  }
}

enum UserType { Doctor, Patient }

extension UTExtension on UserType {
  UserType fromString(String key) {
    if (key.contains("Doctor"))
      return UserType.Doctor;
    else
      return UserType.Patient;
  }

  String value() {
    return this.toString().substring(8);
  }
}
