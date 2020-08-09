import 'package:doc_connect/data_models/appointment.dart';
import 'package:doc_connect/data_models/author.dart';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/chat_user.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/data_models/message.dart';
import 'package:doc_connect/data_models/tip.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/medical_reports.dart';
import 'package:doc_connect/services/tip.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:doc_connect/data_models/medical_report.dart';

class LocalDB {
  bool _initialized = false;

  static Box chatsBox;
  static Box messagesBox;
  static Box userBox;
  static Box patientsBox;
  static Box doctorsBox;
  static Box tipsBox;
  static Box medicalReportsBox;
  static Box forumQuestionsBox;
  static Box forumAnswersBox;
  static Box appointmentsBox;

  Future<void> init() async {
    // init local db
    if (!_initialized) {
      debugPrint("---------------Initialising local db---------------------");
      _initialized = true;
      final appDocumentDir =
          await path_provider.getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);

      _registerAdapters();
      await _initializeBoxes();
      _pullLocalData();
      debugPrint(
          "----------------Local db initialised---------------------------");
    } else {
      debugPrint("Local db already initialised");
    }
  }

  void _registerAdapters() {
    Hive.registerAdapter(ChatAdapter());
    Hive.registerAdapter(ChatUserAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TipAdapter());
    Hive.registerAdapter(MedicalReportAdapter());
    Hive.registerAdapter(ForumQuestionAdapter());
    Hive.registerAdapter(ForumMessageAdapter());
    Hive.registerAdapter(AuthorAdapter());
    Hive.registerAdapter(AppointmentAdapter());
  }

  Future<void> _initializeBoxes() async {
    userBox = await Hive.openBox(Constants.userBox);
    patientsBox = await Hive.openBox(Constants.patientBox);
    doctorsBox = await Hive.openBox(Constants.doctorBox);

    chatsBox = await Hive.openBox(Constants.chatBox);
    messagesBox = await Hive.openBox(Constants.messagesBox);

    tipsBox = await Hive.openBox(Constants.tipsBox);

    medicalReportsBox = await Hive.openBox(Constants.medicalReportsBox);

    forumQuestionsBox = await Hive.openBox(Constants.forumsQuestionsBox);
    forumAnswersBox = await Hive.openBox(Constants.forumsAnswersBox);

    appointmentsBox = await Hive.openBox(Constants.appointmentsBox);
  }

  void _pullLocalData() {
    // Pulling and storing data from local
    UsersService()
      ..pullFromLocalDB();
    ChatService()
      ..pullLocalMessagesAndChats();
    TipService()
      ..pullFromLocalDB();
    MedicalReportService()
      ..pullFromLocalDb();
    ForumsService()
      ..pullFromLocalDb();
  }
}
