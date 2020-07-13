import 'package:doc_connect/views/intro_screens/intro_screen_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/circular_dots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class IntroScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return ViewModelBuilder<IntroScreensViewModel>.reactive(
      viewModelBuilder: () => IntroScreensViewModel(),
      onModelReady: (m) => m.initialise(context),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageView.builder(
                itemCount: model.pages.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: model.pageController,
                onPageChanged: model.onPageChanged,
                itemBuilder: (BuildContext context, int index) =>
                    model.pages[index],
              ),
            ),
            Positioned(
              left: 16.0,
              bottom: 26.0,
              child: _getDots(model),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                  child: model.currentPage == model.pages.length - 1
                      ? IconButton(
//                        highlightColor: Colors.greenAccent,
                          padding: const EdgeInsets.all(0.0),
                          icon: Material(
                            elevation: 4.0,
                            type: MaterialType.circle,
                            color:
                                isDarkTheme ? Colors.white : Colors.greenAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_forward,
                                  color: isDarkTheme
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ),
                          onPressed: model.navigateToLoginScreen,
                        )
                      : AppPlatformButton(
                          onPressed: model.navigateToLoginScreen,
                          text: 'SKIP',
                          color: isDarkTheme
                              ? Colors.black
                              : Theme.of(context).accentColor,
                        )),
            )
          ],
        ),
      ),
    );
  }

  Widget _getDots(IntroScreensViewModel viewModel) {
    return Row(
      children: <Widget>[]..addAll(
          List.generate(
            viewModel.pages.length,
            (index) =>
                index == viewModel.currentPage ? FilledDot() : BlankDot(),
          ),
        ),
    );
  }
}


