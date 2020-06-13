import 'package:doc_connect/data_models/user.dart';
import 'package:flutter/foundation.dart';

class PatientDataProvider with ChangeNotifier {
  ///---------------- current showing screen
  int _currentScreen = 0;

  int get currentScreen => _currentScreen;

  set currentScreen(int value) {
    _currentScreen = value;
    notifyListeners();
  }

  ///---------------- for showing/hiding in doctor home screens[Configs.loader]
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  set showLoader(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  ///----------------- nearby doctors
  List<User> _nearbyDoctors = [];

  List<User> get nearbyDoctors => _nearbyDoctors;

  set nearbyDoctors(List<User> value) {
    _nearbyDoctors = value;
    notifyListeners();
  }
}
