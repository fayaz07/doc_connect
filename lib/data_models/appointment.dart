import 'dart:convert';
import 'package:doc_connect/data_models/chat_user.dart';
import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: 4)
class Appointment {
  @HiveField(0)
  String id;

  @HiveField(1)
  String patient;

  @HiveField(2)
  String doctor;

  @HiveField(3)
  bool requestAccepted;

  @HiveField(4)
  bool requestRejected;

  @HiveField(5)
  bool offered;

  @HiveField(6)
  bool offerAccepted;

  @HiveField(7)
  bool offerRejected;

  @HiveField(8)
  DateTime scheduledDate;

  @HiveField(9)
  String problemDescription;

  @HiveField(10)
  String problem;

  @HiveField(11)
  String preMedicalReport;

  @HiveField(12)
  ChatUser endUser;

  @HiveField(13)
  bool cancelledByDoctor;

  @HiveField(14)
  bool cancelledByPatient;

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

  static Map<String, Appointment> parseList(String jsonResponse) {
    final jsonList = json.decode(jsonResponse)["appointments"];
    Map<String, Appointment> list = Map();
    for (var c in jsonList) {
      final dd = Appointment.fromJSON(c);
      list[dd.id] = dd;
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
