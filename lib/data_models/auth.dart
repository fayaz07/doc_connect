class Auth {
  String email;
  String authToken;
  String refreshToken;
  bool loggedIn;
  bool social;
  bool isDoctor;

  Auth(
      {this.email,
      this.authToken,
      this.refreshToken,
      this.loggedIn,
      this.social,
      this.isDoctor});

  @override
  String toString() {
    return 'Auth{email: $email, authToken: $authToken, refreshToken: $refreshToken, loggedIn: $loggedIn, isDoctor: $isDoctor}';
  }
}
