import 'package:doc_connect/data_models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UsersProvider with ChangeNotifier {
  User _user = User();

  parseUserDocPatientsData(var decodedJson) {
    _user = User.fromJSON(decodedJson["user"]);
    notifyListeners();
    if (_user.isDoctor) {
      compute(User.fromJSONList, decodedJson["patients"])
          .then((value) {
            _patients = value;
            notifyListeners();
          });
    } else {
      compute(User.fromJSONList, decodedJson["doctors"])
          .then((value) {
            _doctors = value;
            notifyListeners();
          });
    }
  }

  Map<String,User> _doctors = Map();
  Map<String,User>_patients = Map();


  User get user => _user;

  set user(User value) {
    _user = value;
    print('set value $value');
    notifyListeners();
  }

  Map<String, User> get patients => _patients;

  set patients(Map<String, User> value) {
    _patients = value;
    notifyListeners();
  }

  Map<String, User> get doctors => _doctors;

  set doctors(Map<String, User> value) {
    _doctors = value;
    notifyListeners();
  }
}
