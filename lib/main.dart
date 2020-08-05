import 'package:doc_connect/services/app_data.dart';
import 'package:doc_connect/services/appointments.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/medical_reports.dart';
import 'package:doc_connect/services/notifications.dart';
import 'package:doc_connect/services/tip.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/views/intro_screens/intro_screen_view_model.dart';
import 'package:doc_connect/views/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    OTS(
      showNetworkUpdates: false,
      persistNoInternetNotification: false,
      loader: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => IntroScreensViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppData(),
          ),
          ChangeNotifierProvider(
            create: (context) => UsersService(),
          ),
          ChangeNotifierProvider(
            create: (context) => ForumsService(),
          ),
          ChangeNotifierProvider(
            create: (context) => ChatService()..fetchChats(context),
          ),
          ChangeNotifierProvider(
            create: (context) => NotificationService(),
          ),
          ChangeNotifierProvider(
            create: (context) => MedicalReportService(),
          ),
          ChangeNotifierProvider(
            create: (context) => AppointmentService(),
          ),
          ChangeNotifierProvider(
            create: (context) => TipService(),
          ),
        ],
        child: DocConnectApp(),
      ),
    ),
  );
  _setupLogging();
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class DocConnectApp extends StatefulWidget {
  @override
  _DocConnectAppState createState() => _DocConnectAppState();
}

class _DocConnectAppState extends State<DocConnectApp> {
  @override
  Widget build(BuildContext context) {
//    final appData = Provider.of<AppData>(context);
//    appData.isDarkTheme =
//        MediaQuery.of(context).platformBrightness == Brightness.dark
//            ? true
//            : false;
//    final theme = appData.isDarkTheme ? AppTheme.dark : AppTheme.light;

    return PlatformApp(
      title: 'Doc Connect',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      material: (context, platformTarget) =>
          MaterialAppData(
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
          ),
      cupertino: (context, platformTarget) =>
          CupertinoAppData(
//        theme: CupertinoThemeData(),
          ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
