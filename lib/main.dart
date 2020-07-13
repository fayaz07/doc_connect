import 'package:doc_connect/services/app_data.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/views/intro_screens/intro_screen_view_model.dart';
import 'package:doc_connect/views/splash_screen/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
            create: (context) => UsersProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ForumsProvider(),
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

// ignore: must_be_immutable
class DocConnectApp extends StatelessWidget {

  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  @override
  Widget build(BuildContext context) {
    fetchToken();

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
      material: (context, platformTarget) => MaterialAppData(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
      ),
      cupertino: (context, platformTarget) => CupertinoAppData(
//        theme: CupertinoThemeData(),
          ),
    );
  }

  bool fetched = false;

  Future<void> fetchToken() async {
    if (!fetched) {
      fetched = true;
      print(await _firebaseMessaging.getToken());


      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
//        _showItemDialog(message);
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
//        _navigateToItemDetail(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
//        _navigateToItemDetail(message);
        },
      );
    }
  }
}
