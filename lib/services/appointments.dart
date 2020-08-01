import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dartx/dartx.dart';

class AppointmentService with ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _appointmentsLoaded = false;

  AppointmentService() {
    _fetchAppointments();
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    _appointments = _appointments.distinctBy((e) => e.id).toList();
    notifyListeners();
  }

  Future<void> _fetchAppointments() async {
    if (!_appointmentsLoaded) {
      _appointmentsLoaded = true;
      final response = await APIService.api.getAppointments();
      if (response.isSuccessful) {
        final parsed =
            await compute(Appointment.parseList, response.body.toString());
        _appointments.addAll(parsed);
        _appointments = _appointments.distinctBy((e) => e.id).toList();
        notifyListeners();
      }
    }
  }

  List<Appointment> get appointments => _appointments;

  set appointments(List<Appointment> value) {
    _appointments = value;
    notifyListeners();
  }
}
