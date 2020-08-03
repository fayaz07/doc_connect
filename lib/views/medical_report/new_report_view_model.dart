import 'dart:convert';
import 'package:doc_connect/services/appointments.dart';

import '../../utils/validators.dart';
import 'package:doc_connect/data_models/medical_report.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class NewMedicalReportViewModel extends ChangeNotifier {
  BuildContext _context;
  int currentPage = 0;
  MedicalReport _report = MedicalReport();
  String _appointmentId;

  final PageController pageController = PageController();
  final formKey = GlobalKey<FormState>();

  void init(BuildContext context, String appointmentId) {
    _context = context;
    report = Provider.of<UsersService>(context, listen: false).fitness;
    _appointmentId = appointmentId;
  }

  void handleBack() {
    if (currentPage == 0) {
      AppToast.show(text: "wait");
    } else {
      pageController.animateToPage(currentPage - 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOutCirc);
    }
  }

  void handleNext() {
    FocusScope.of(_context).requestFocus(FocusNode());
    switch (currentPage) {
      // height, weight
      case 0:
        updatePhysiqueDetails();
        break;
      // blood
      case 1:
        _goToNextPage();
        break;
      // vision
      case 2:
        _goToNextPage();
        break;
      // hearing
      case 3:
        _goToNextPage();
        break;
      // physical disability
      case 4:
        _goToNextPage();
        break;
      // by birth diseases
      case 5:
        _goToNextPage();
        break;
      // psychological issues
      case 6:
        _goToNextPage();
        break;
    // surgeries
      case 7:
        _goToNextPage();
        break;
    // alcohol and smoking
      case 8:
        _goToNextPage();
        break;
    // other diseases
      case 9:
        save();
        break;
    }
  }

  save() async {
    showLoader(isModal: true);
    final response = await APIService.api
        .saveReport(jsonEncode(MedicalReport.toJSON(report)));
    if (response.isSuccessful) {
      Provider
          .of<UsersService>(_context, listen: false)
          .user
          .preMedicalReportId =
      json.decode(response.body)["medicalReport"]["_id"];

      // update and save if appointment id is not null
      if (!_appointmentId.isNull()) {
        final patchAppointment =
        await APIService.api.updateAppointment(jsonEncode({
          "appointment_id": _appointmentId,
          "pre_medical_report": json.decode(response.body)["medicalReport"]
          ["_id"],
        }));
        if (patchAppointment.isSuccessful) {
          var a = Provider
              .of<AppointmentService>(_context, listen: false)
              .appointments
              .firstWhere((element) => element.id.contains(_appointmentId));
          a.preMedicalReport =
          json.decode(response.body)["medicalReport"]["_id"];
          Provider.of<AppointmentService>(_context, listen: false)
              .updateAppointment(a);
          AppToast.show(text: "Medical report submitted successfully");

          Navigator.of(_context).pop();
        } else {
          AppToast.showError(patchAppointment);
        }
      } else {
        AppToast.showError(response);
      }
    }
    hideLoader();
  }

  selectBloodGroup(BloodGroup group) {
    Provider
        .of<UsersService>(_context, listen: false)
        .fitness
        .bloodGroup =
        group;
    notifyFFitness();
  }

  updatePhysiqueDetails() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    report.bmi =
    (report.weight / ((report.height / 100) * (report.height / 100)));
    _goToNextPage();
    notifyFFitness();
  }

  _goToNextPage() {
//    print(report);
    pageController.nextPage(
        duration: Duration(milliseconds: 400), curve: Curves.easeInOutCirc);
  }

  notifyFFitness() {
    report = report;
  }

//  Fitness get fitness => _context == null
//      ? Fitness()
//      : Provider.of<UsersProvider>(_context).fitness;

  MedicalReport get report => _report;

  set report(MedicalReport value) {
    _report = value;
    notifyListeners();
  }
}
