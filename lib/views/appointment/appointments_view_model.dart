import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/appointment/appointment_detailed.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppointmentsViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  Map<String, Appointment> get appointments => _context == null
      ? Map<String, Appointment>()
      : Provider.of<AppointmentService>(_context).appointments;

  User get user => _context == null
      ? User()
      : Provider.of<UsersService>(_context, listen: false).user;

  bool get loading => _context == null
      ? true
      : Provider.of<AppointmentService>(_context).loading;

  bool get hasError => _context == null
      ? false
      : Provider.of<AppointmentService>(_context).hasError;

  void appointmentTap(Appointment appointment) {
    Navigator.of(_context).push(AppNavigation.route(
        AppointmentDetailed(appointmentId: appointment.id)));
  }
}
