import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/medical_report.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ots/ots.dart';

class UsersService with ChangeNotifier {
  static User _user = User();
  static MedicalReport _fitness = MedicalReport();
  static Map<String, User> _doctors = Map();
  static Map<String, User> _patients = Map();

  Future<void> saveDetails() async {
    final Response response = await APIService.api.updateUserDetails(
      jsonEncode(User.toJSON(user)),
    );
    hideLoader();
    if (response.isSuccessful) {
      _updateUser(user);
//      APIService()
//        ..getDashboard(_context)
//            .then((value) => _navigateToHomeScreen())
//            .catchError((error) => AppToast.show(text: "Can\'t fetch data"));
    } else {
      AppToast.showLong(text: json.decode(response.error)["message"]);
    }
    return;
  }

  void parseUserDocPatients(var decodedJson) {
    _user = User.fromJSON(decodedJson["user"]);
    notifyListeners();
    _updateUser(user);

    if (_user.isDoctor) {
      compute(User.fromJSONList, decodedJson["patients"]).then((value) {
        _patients.addAll(value);
        _addAllPatients(patients);
        // debugPrint(_patients.toString());
        notifyListeners();
      });
    } else {
      compute(User.fromJSONList, decodedJson["doctors"]).then((value) {
        _doctors.addAll(value);
        _addAllDoctors(doctors);
        // debugPrint(_doctors.toString());
        notifyListeners();
      });
    }
  }

  void fetchPatient(String patientId) {
    /// Todo: implement this
  }

  void fetchDoctor(String doctorId) {
    /// Todo: implement this
  }

  ///------------------------------- LocalDb -----------------------------------
  void pullFromLocalDB() {
    /// fetch the current user's data
    if (LocalDB.userBox.length > 0) _user = LocalDB.userBox.getAt(0);

    /// fetch patients
    if (LocalDB.patientsBox.length > 0)
      for (var value in LocalDB.patientsBox.keys) {
        _patients[value] = LocalDB.patientsBox.get(value, defaultValue: User());
      }

    /// fetch doctors
    if (LocalDB.doctorsBox.length > 0)
      for (var value in LocalDB.doctorsBox.keys) {
        _doctors[value] = LocalDB.doctorsBox.get(value, defaultValue: User());
      }

    notifyListeners();
  }

  Future<void> _updateUser(User user) async {
    if (LocalDB.userBox.length > 0)
      await LocalDB.userBox.putAt(0, user);
    else
      await LocalDB.userBox.add(user);
  }

//  Future<void> _addPatient(User patient) async {
//    await LocalDB.patientsBox.put(patient.id, patient);
//  }

  Future<void> _addAllPatients(Map<String, User> patients) async {
    await LocalDB.patientsBox.putAll(patients);
  }

//  Future<void> _addDoctor(User doctor) async {
//    await LocalDB.doctorsBox.put(doctor.id, doctor);
//  }

  Future<void> _addAllDoctors(Map<String, User> doctors) async {
    await LocalDB.doctorsBox.putAll(doctors);
  }

  /// ---------------------------- Getters and setters -------------------------
  User get user => _user;

  set user(User value) {
    _user = value;
//    print('set value $value');
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

  MedicalReport get fitness => _fitness;

  set fitness(MedicalReport value) {
    _fitness = value;
    notifyListeners();
  }
}
