import 'package:doc_connect/services/app_data.dart';
import 'package:doc_connect/view_models/intro_screen.dart';
import 'package:doc_connect/views/intro_screens/intro_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    OTS(
      showNetworkUpdates: true,
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
          )
        ],
        child: DocConnectApp(),
      ),
    ),
  );
}

class DocConnectApp extends StatelessWidget {
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
      home: IntroScreens(),
      material: (context, platformTarget) => MaterialAppData(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
      ),
      cupertino: (context, platformTarget) => CupertinoAppData(
//        theme: CupertinoThemeData(),
          ),
    );
  }
}
