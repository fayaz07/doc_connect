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

  @override
  String toString() {
    return 'Auth{authToken: $authToken, refreshToken: $refreshToken, userType: $userType}';
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
