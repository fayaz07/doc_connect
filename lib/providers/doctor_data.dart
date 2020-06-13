import 'package:doc_connect/data_models/user.dart';
import 'package:flutter/foundation.dart';

class DoctorDataProvider with ChangeNotifier {
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

  /// ---------------- nearby patients
  List<User> _nearbyPatients = [];

  List<User> get nearbyPatients => _nearbyPatients;

  set nearbyPatients(List<User> value) {
    _nearbyPatients = value;
    notifyListeners();
  }

}
