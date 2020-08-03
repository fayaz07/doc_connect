import 'package:doc_connect/views/appointment/appointments.dart';
import 'package:doc_connect/views/chat/chats_list.dart';
import 'package:doc_connect/views/home/home.dart';
import 'package:doc_connect/views/notification/notifications.dart';
import 'package:flutter/cupertino.dart';

class TabsScreenViewModel extends ChangeNotifier {
//  BuildContext _context;
  int _currentScreenIndex = 0;
  Widget _currentScreen = HomeScreen();

  final _screens = [
    HomeScreen(),
    AppointmentsScreen(),
    NotificationsScreen(),
    ChatsList()
  ];

//  instantiate(BuildContext context) {
//    _context = context;
//  }

  void screenChanged(int i) {
    currentScreenIndex = i;
  }

  int get currentScreenIndex => _currentScreenIndex;

  set currentScreenIndex(int value) {
    _currentScreenIndex = value;
    _currentScreen = _screens[value];
    notifyListeners();
  }

  Widget get currentScreen => _currentScreen;
}
