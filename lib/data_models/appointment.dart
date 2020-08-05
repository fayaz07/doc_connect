import 'dart:convert';
import 'package:doc_connect/data_models/chat_user.dart';

class Appointment {
  String id;
  String patient, doctor;
  bool requestAccepted, requestRejected, offered, offerAccepted, offerRejected;
  DateTime scheduledDate;
  String problemDescription;
  String problem;
  String preMedicalReport;
  ChatUser endUser;
  bool cancelledByDoctor, cancelledByPatient;

  Appointment(
      {this.id,
      this.patient,
      this.doctor,
      this.requestAccepted = false,
      this.requestRejected = false,
      this.offered = false,
      this.offerAccepted = false,
      this.offerRejected = false,
      this.scheduledDate,
      this.problemDescription,
      this.problem,
      this.preMedicalReport,
      this.endUser,
      this.cancelledByDoctor = false,
      this.cancelledByPatient = false});

  static Appointment fromJSON(var map) {
    return Appointment(
        id: map["_id"],
        patient: map["patient"],
        doctor: map["doctor"],
        requestAccepted: map["request_accepted"] ?? false,
        requestRejected: map["request_rejected"] ?? false,
        offered: map["offered"] ?? false,
        offerAccepted: map["offer_accepted"] ?? false,
        offerRejected: map["offer_rejected"] ?? false,
        scheduledDate: map["scheduled_date"] != null
            ? DateTime.parse(map["scheduled_date"])
            : null,
        problemDescription: map["problem_description"],
        problem: map["problem"],
        preMedicalReport: map["pre_medical_report"],
        endUser:
        map["eu"] != null ? ChatUser.fromJSON(map["eu"][0]) : ChatUser(),
        cancelledByDoctor: map["doc_cancelled"] ?? false,
        cancelledByPatient: map["patient_cancelled"] ?? false);
  }

  static List<Appointment> parseList(String jsonResponse) {
    final jsonList = json.decode(jsonResponse)["appointments"];
    List<Appointment> list = [];
    for (var c in jsonList) {
      list.add(Appointment.fromJSON(c));
    }
    return list;
  }

  static Map<String, dynamic> toJSON(Appointment appointment) {
    return {
      "patient": appointment.patient,
      "doctor": appointment.doctor,
      "problem": appointment.problem,
      "problem_description": appointment.problemDescription,
      "pre_medical_report": appointment.preMedicalReport,
    };
  }
}
