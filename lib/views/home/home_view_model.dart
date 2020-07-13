import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/forum/all_forums.dart';
import 'package:doc_connect/views/profile/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreenViewModel extends ChangeNotifier {
  BuildContext _context;
  int _currentScreenIndex = 0;

  instantiate(BuildContext context) {
    _context = context;
  }

  void screenChanged(int i) {
    currentScreenIndex = i;
  }

  void goToProfileScreen() {
    Navigator.of(_context).push(AppNavigation.route(Profile()));
  }

  void goToForums() {
    Navigator.of(_context).push(AppNavigation.route(Forums()));
  }

  User get user =>
      _context == null ? User() : Provider.of<UsersProvider>(_context).user;

  int get currentScreenIndex => _currentScreenIndex;

  set currentScreenIndex(int value) {
    _currentScreenIndex = value;
    notifyListeners();
  }
}
