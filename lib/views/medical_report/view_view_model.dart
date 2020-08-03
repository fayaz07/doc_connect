import 'package:doc_connect/data_models/medical_report.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/services/medical_reports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ViewMedicalReportViewModel extends ChangeNotifier {
  BuildContext _context;
  String _id;
  bool _loading = true;

  void init(BuildContext context, String id) {
    _context = context;
    _id = id;
    Provider.of<MedicalReportService>(context, listen: false)
        .fetchIfDoesNotExist(id)
        .then((value) => loading = false);
  }

//  User get user => _context == null
//      ? User()
//      : Provider.of<UsersService>(_context, listen: false).user;

  MedicalReport get medicalReport => _context == null || _id == null
      ? MedicalReport()
      : Provider.of<MedicalReportService>(_context).medicalReports[_id] ??
          MedicalReport();

//  bool get loading => _context == null
//      ? true
//      : Provider.of<AppointmentService>(_context).loading;

  bool get hasError => _context == null
      ? false
      : Provider.of<AppointmentService>(_context).hasError;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
