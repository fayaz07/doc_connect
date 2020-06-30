import 'package:flutter/cupertino.dart';

class SplashScreenViewModel extends ChangeNotifier {
  BuildContext _context;

  Future<void> instantiate(BuildContext context) async {
    _context = context;
    await Future.delayed(Duration(seconds: 1));

  }

  void _navigateToIntroScreen() {}

  void _navigateToLoginScreen() {}
}
