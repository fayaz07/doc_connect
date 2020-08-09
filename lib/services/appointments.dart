import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//import 'package:dartx/dartx.dart';

class AppointmentService with ChangeNotifier {
  Map<String, Appointment> _appointments = Map();
  bool _loading = true;
  bool _hasError = false;

  AppointmentService() {
    _fetchAppointments();
  }

  void addAppointment(Appointment appointment) {
    _appointments[appointment.id] = appointment;
    _addAppointmentToLocalDB(appointment);
//    _appointments = _appointments.distinctBy((e) => e.id).toList();
    notifyListeners();
  }

  void updateAppointment(Appointment appointment) {
//    _appointments.removeWhere((element) => element.id == appointment.id);
//    _appointments.add(appointment);
    _appointments[appointment.id] = appointment;
    _addAppointmentToLocalDB(appointment);
    notifyListeners();
  }

  Future<void> _fetchAppointments() async {
    if (!_hasError) {
      loading = true;
      final response = await APIService.api.getAppointments();
      if (response.isSuccessful) {
        final parsed =
            await compute(Appointment.parseList, response.body.toString());
        _appointments.addAll(parsed);
        _addAllAppointmentsToLocalDB(parsed);
//        _appointments = _appointments.distinctBy((e) => e.id).toList();
      } else {
        _hasError = true;
        AppToast.showError(response);
      }
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> _addAppointmentToLocalDB(Appointment appointment) async {
    await LocalDB.appointmentsBox.put(appointment.id, appointment);
  }

  Future<void> _addAllAppointmentsToLocalDB(
      Map<String, Appointment> appointments) async {
    await LocalDB.appointmentsBox.putAll(appointments);
  }

  void pullFromLocalDB() {
    if (LocalDB.appointmentsBox.length > 0) {
      LocalDB.appointmentsBox.keys.forEach((key) {
        _appointments[key] =
            LocalDB.appointmentsBox.get(key, defaultValue: Appointment());
      });
    }
  }

  ///----------------------- Getters and setters -------------------------------
  Map<String, Appointment> get appointments => _appointments;

  set appointments(Map<String, Appointment> value) {
    _appointments = value;
    notifyListeners();
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
