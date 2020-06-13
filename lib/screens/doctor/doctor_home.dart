import 'package:doc_connect/providers/doctor_data.dart';
import 'package:doc_connect/screens/chat/chats.dart';
import 'package:doc_connect/screens/doctor/doctor_dashboard.dart';
import 'package:doc_connect/screens/doctor/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  final pages = [
    DoctorDashboard(
      key: PageStorageKey('doctor-dashboard' + UniqueKey().toString()),
    ),
    Chats(
      key: PageStorageKey('doctor-chats' + UniqueKey().toString()),
    ),
    DoctorProfile(
      key: PageStorageKey('doctor-profile' + UniqueKey().toString()),
    )
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DoctorDataProvider>(context);

    return Scaffold(
//      appBar: MyAppbar(
//        title: 'Home',
//        showBackButton: false,
//        handleGoBack: () {},
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.search, color: Colors.white),
//            onPressed: () {
//              Navigator.of(context).push(AppNavigation.route(SearchDoctor()));
//            },
//          )
//        ],
//      ),
      body: SafeArea(
        child: PageStorage(
          bucket: bucket,
          child: _getBody(dataProvider),
        ),
      ),
      bottomNavigationBar: _getBottomNavbar(dataProvider),
    );
  }

  Widget _getBody(DoctorDataProvider dataProvider) {
    switch (dataProvider.currentScreen) {
      case 0:
        return pages[0];
        break;
      case 1:
        return pages[1];
        break;
      case 2:
        return pages[2];
        break;
      default:
        return pages[0];
        break;
    }
  }

  /// ----------- bottom navigation bar
  Widget _getBottomNavbar(DoctorDataProvider dataProvider) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Dashboard'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('Chats'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: dataProvider.currentScreen,
      onTap: (int i) {
        dataProvider.currentScreen = i;
      },
    );
  }
}
