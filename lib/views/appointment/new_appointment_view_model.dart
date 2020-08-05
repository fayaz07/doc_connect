import 'dart:convert';
import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/data_models/chat_user.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class NewAppointViewModel extends ChangeNotifier {
  BuildContext _context;
  Appointment _appointment = Appointment();
  final formKey = GlobalKey<FormState>();

  void init(BuildContext context) {
    _context = context;
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  void validateForm(User guestUser) {
    if (!formKey.currentState.validate()) {
      AppToast.show(text: "Please fill valid details");
      return;
    }
    FocusScope.of(_context).requestFocus(FocusNode());
    formKey.currentState.save();

    if (guestUser.isDoctor) {
      appointment.doctor = guestUser.id;
    } else {
      appointment.patient = guestUser.id;
      appointment.offered = true;
    }

    appointment.endUser = ChatUser(
        firstName: guestUser.firstName,
        lastName: guestUser.lastName,
        photoUrl: guestUser.photoUrl,
        userId: guestUser.id);

    _offerOrApplyForAppointment();
  }

  Future<void> _offerOrApplyForAppointment() async {
    showLoader(isModal: true);
    final body = jsonEncode(Appointment.toJSON(appointment));
    final response = await APIService.api.offerOrApplyForAppointment(body);
    hideLoader();
    if (response.isSuccessful) {
      AppToast.show(text: json.decode(response.body)["message"]);
      final resData =
          Appointment.fromJSON(json.decode(response.body)["appointment"]);
      appointment.id = resData.id;
      Provider.of<AppointmentService>(_context, listen: false)
          .addAppointment(appointment);
      pop();
    } else {
      AppToast.showError(response);
    }
  }

  Appointment get appointment => _appointment;

  set appointment(Appointment value) {
    _appointment = value;
    notifyListeners();
  }
}
