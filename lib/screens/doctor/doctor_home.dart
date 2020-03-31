import 'package:covid19doc/providers/doctor_data.dart';
import 'package:covid19doc/screens/doctor/doctor_dashboard.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
            onPressed: () {},
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
        return DoctorDashboard();
        break;
      case 1:
        return DoctorDashboard();
        break;
      case 2:
        return DoctorDashboard();
        break;
      default:
        return DoctorDashboard();
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
