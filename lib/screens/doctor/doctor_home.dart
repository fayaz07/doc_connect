import 'package:covid19doc/providers/doctor_data.dart';
import 'package:covid19doc/screens/chat/chats.dart';
import 'package:covid19doc/screens/doctor/doctor_dashboard.dart';
import 'package:covid19doc/screens/doctor/doctor_profile.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../search_doctor.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DoctorDataProvider>(context);

    return Scaffold(
      appBar: MyAppbar(
        title: 'Home',
        showBackButton: false,
        handleGoBack: () {},
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(AppNavigation.route(SearchDoctor()));
            },
          )
        ],
      ),
      body: _getBody(dataProvider),
      bottomNavigationBar: _getBottomNavbar(dataProvider),
    );
  }

  Widget _getBody(DoctorDataProvider dataProvider) {
    switch (dataProvider.currentScreen) {
      case 0:
        return DoctorDashboard(
          dataProvider: dataProvider,
        );
        break;
      case 1:
        return Chats();
        break;
      case 2:
        return DoctorProfile();
        break;
      default:
        return DoctorDashboard(
          dataProvider: dataProvider,
        );
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
