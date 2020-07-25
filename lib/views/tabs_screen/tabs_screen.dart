import 'package:doc_connect/views/tabs_screen/tabs_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsScreenViewModel>.reactive(
      viewModelBuilder: () => TabsScreenViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        body: model.currentScreen,
        bottomNavBar: PlatformNavBar(
          currentIndex: model.currentScreenIndex,
          itemChanged: model.screenChanged,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), title: Text('Notifications')),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), title: Text('Chats')),
          ],
        ),
      ),
    );
  }
}
