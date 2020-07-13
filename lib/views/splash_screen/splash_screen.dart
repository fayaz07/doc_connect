import 'package:doc_connect/views/splash_screen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenViewModel>.nonReactive(
      viewModelBuilder: () => SplashScreenViewModel(),
      onModelReady: (m) => m.instantiate(context),
      builder: (context, model, child) => PlatformScaffold(
        body: Center(
          child: FlutterLogo(size: 100.0),
        ),
      ),
    );
  }
}
