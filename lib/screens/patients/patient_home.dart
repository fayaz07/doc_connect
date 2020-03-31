import 'package:covid19doc/providers/patient_data.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'patient_dashboard.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<PatientDataProvider>(context);

    return Scaffold(
      appBar: MyAppbar(
        title: 'Home',
        showBackButton: false,
        handleGoBack: () {},
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          )
        ],
      ),
      body: _getBody(dataProvider),
      bottomNavigationBar: _getBottomNavbar(dataProvider),
    );
  }

  Widget _getBody(PatientDataProvider dataProvider) {
    switch (dataProvider.currentScreen) {
      case 0:
        return PatientDashboard();
        break;
      case 1:
        return PatientDashboard();
        break;
      case 2:
        return PatientDashboard();
        break;
      default:
        return PatientDashboard();
        break;
    }
  }

  /// ----------- bottom navigation bar
  Widget _getBottomNavbar(PatientDataProvider dataProvider) {
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
