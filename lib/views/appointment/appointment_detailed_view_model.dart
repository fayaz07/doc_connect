import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/medical_report/new_report.dart';
import 'package:doc_connect/views/medical_report/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';
import '../../utils/validators.dart';

class AppointmentDetailedViewModel extends ChangeNotifier {
  BuildContext _context;
  String _appointmentId;

  void init(BuildContext context, String appointmentId) {
    _context = context;
    _appointmentId = appointmentId;
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  Appointment get appointment => _context == null || _appointmentId.isNull()
      ? Appointment()
      : Provider.of<AppointmentService>(_context).appointments[_appointmentId];

  User get currentUser => _context == null
      ? User()
      : Provider.of<UsersService>(_context, listen: false).user;

  Future<void> acceptOffer() async {
    final response = await _accept();
    if (response.isSuccessful) {
      AppToast.show(text: "Offer has been accepted successfully");
      var appointmentS = _getAppointment();
      appointmentS.offerAccepted = true;
      _updateAppointment(appointmentS);
    } else {
      AppToast.showError(response);
    }
  }

  Future<void> acceptRequest() async {
    final response = await _accept();
    if (response.isSuccessful) {
      AppToast.show(text: "Request has been accepted successfully");
      var appointmentS = _getAppointment();
      appointmentS.requestAccepted = true;
      _updateAppointment(appointmentS);
    } else {
      AppToast.showError(response);
    }
  }

  Future<Response> _accept() async {
    showLoader(isModal: true);
    final response = await APIService.api.acceptAppointmentReqOff(
        jsonEncode({"appointment_id": _appointmentId}));
    hideLoader();
    return response;
  }

  Future<Response> _reject() async {
    showLoader(isModal: true);
    final response = await APIService.api.rejectAppointmentReqOff(
        jsonEncode({"appointment_id": _appointmentId}));
    hideLoader();
    return response;
  }

  Future<void> rejectRequest() async {
    final response = await _reject();
    if (response.isSuccessful) {
      AppToast.show(text: "Request has been rejected successfully");
      var appointmentS = _getAppointment();
      appointmentS.requestRejected = true;
      _updateAppointment(appointmentS);
    } else {
      AppToast.showError(response);
    }
  }

  Future<void> rejectOffer() async {
    final response = await _reject();
    if (response.isSuccessful) {
      AppToast.show(text: "Offer has been rejected successfully");
      var appointmentS = _getAppointment();
      appointmentS.offerRejected = true;
      _updateAppointment(appointmentS);
    } else {
      AppToast.showError(response);
    }
  }

  Future<void> cancelAppointment() async {
    final response = await APIService.api
        .cancelAppointment(jsonEncode({"appointment_id": _appointmentId}));
    if (response.isSuccessful) {
      AppToast.show(text: "Appointment cancelled successfully");
      var appointmentS = _getAppointment();
      if (currentUser.isDoctor)
        appointmentS.cancelledByDoctor = true;
      else
        appointmentS.cancelledByPatient = true;
      _updateAppointment(appointmentS);
    } else {
      AppToast.showError(response);
    }
  }

  void changeDate() {
    DatePicker.showDatePicker(
      _context,
      showTitleActions: true,
      minTime: DateTime.now().add(Duration(days: 1)),
      maxTime: DateTime.now().add(Duration(days: 31)),
//      onChanged: (date) {
//        print('change $date');
//      },
      onConfirm: (date) async {
        print('confirm $date');
        showLoader(isModal: true);
        final response = await APIService.api.updateAppointment(jsonEncode({
          "appointment_id": _appointmentId,
          "scheduled_date": date.toIso8601String()
        }));
        if (response.isSuccessful) {
          AppToast.show(text: "Scheduled date updated");
          var appointmentS = _getAppointment();
          appointmentS.scheduledDate = date;
          _updateAppointment(appointmentS);
        } else {
          AppToast.showError(response);
        }
        hideLoader();
      },
      currentTime: DateTime.now(),
    );
  }

  Appointment _getAppointment() {
    return Provider
        .of<AppointmentService>(_context, listen: false)
        .appointments[_appointmentId];
  }

  void _updateAppointment(Appointment aa) {
    Provider.of<AppointmentService>(_context, listen: false)
        .updateAppointment(aa);
  }

  static String getStatus(bool isCurrentUserADoctor, Appointment appointment) {
    if (appointment.cancelledByPatient)
      return "Patient cancelled the appointment";
    if (appointment.cancelledByDoctor)
      return "Doctor cancelled the appointment";
    // if the user is a doctor
    if (isCurrentUserADoctor) {
      // if doctor offered the appointment
      if (appointment.offered) {
        if (appointment.offerAccepted) {
          return "Patient accepted the offer";
        }
        if (appointment.offerRejected) {
          return "Patient rejected the offer";
        }
        return "Patient didn\'t respond";
      }

      // patient has requested the doctor
      if (appointment.requestAccepted) {
        return "You accepted the request";
      }

      if (appointment.requestRejected) {
        return "You rejected the request";
      }
      return "You didn\'t respond";
    }

    // if the user is patient
    if (appointment.offered) {
      if (appointment.offerAccepted) {
        return "You accepted the offer";
      }
      if (appointment.offerRejected) {
        return "You rejected the offer";
      }
      return "You didn\'t respond to the offer";
    }

    if (appointment.requestAccepted) {
      return "You request was accepted by the doctor";
    }

    if (appointment.requestRejected) {
      return "You request was rejected by the doctor";
    }

    return "Doctor didn\'t respond to your offer";
  }

  Future<void> submitReport() async {
    print(currentUser.preMedicalReportId);
    if (currentUser.preMedicalReportId.isNull())
      Navigator.of(_context).push(
        AppNavigation.route(
          NewMedicalReport(
            appointmentId: _appointmentId,
          ),
        ),
      );
    else {
      final patchAppointment =
          await APIService.api.updateAppointment(jsonEncode({
        "appointment_id": _appointmentId,
        "pre_medical_report": currentUser.preMedicalReportId,
      }));
      if (patchAppointment.isSuccessful) {
        var a = Provider
            .of<AppointmentService>(_context, listen: false)
            .appointments[_appointmentId];
        a.preMedicalReport = currentUser.preMedicalReportId;
        Provider.of<AppointmentService>(_context, listen: false)
            .updateAppointment(a);
        AppToast.show(text: "Medical report submitted successfully");
      } else {
        AppToast.showError(patchAppointment);
      }
    }
  }

  void viewMedicalReport() {
    Navigator.of(_context).push(AppNavigation.route(
        ViewMedicalReport(id: _getAppointment().preMedicalReport)));
  }
}
