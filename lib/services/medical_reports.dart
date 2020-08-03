import 'dart:convert';
import 'package:doc_connect/data_models/medical_report.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';

class MedicalReportService extends ChangeNotifier {
  Map<String, MedicalReport> _medicalReports = Map();

  bool _loading = false;
  bool _hasError = false;

  Future<bool> fetchIfDoesNotExist(String id) async {
    if (!_medicalReports.containsKey(id)) {
      _loading = true;
      final response = await APIService.api.getReport(id);
      if (response.isSuccessful) {
        MedicalReport medicalReport = MedicalReport.fromJSON(
            json.decode(response.body)["medical_report"]);
        _medicalReports[medicalReport.id] = medicalReport;
      } else {
        hasError = true;
        AppToast.showError(response);
      }
      _loading = false;
      return true;
    }
    return true;
  }

  Map<String, MedicalReport> get medicalReports => _medicalReports;

  set medicalReports(Map<String, MedicalReport> value) {
    _medicalReports = value;
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
    try {
      notifyListeners();
    } catch (err) {}
  }
}
