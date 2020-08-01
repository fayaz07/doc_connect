import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/services/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppointmentsViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  List<Appointment> get appointments => _context == null
      ? <Appointment>[]
      : Provider.of<AppointmentService>(_context).appointments;

  User get user => _context == null
      ? User()
      : Provider.of<UsersProvider>(_context, listen: false).user;
}
