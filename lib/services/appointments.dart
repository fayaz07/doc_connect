import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dartx/dartx.dart';

class AppointmentService with ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _loading = true;
  bool _hasError = false;

  AppointmentService() {
    _fetchAppointments();
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    _appointments = _appointments.distinctBy((e) => e.id).toList();
    notifyListeners();
  }

  void updateAppointment(Appointment appointment) {
    _appointments.removeWhere((element) => element.id == appointment.id);
    _appointments.add(appointment);
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
        _appointments = _appointments.distinctBy((e) => e.id).toList();
      } else {
        _hasError = true;
        AppToast.showError(response);
      }
      _loading = false;
      notifyListeners();
    }
  }

  List<Appointment> get appointments => _appointments;

  set appointments(List<Appointment> value) {
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
