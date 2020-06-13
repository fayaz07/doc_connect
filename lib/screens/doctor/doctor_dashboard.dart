import 'package:doc_connect/providers/doctor_data.dart';
import 'package:doc_connect/providers/forums.dart';
import 'package:doc_connect/screens/forum/view_all_forums.dart';
import 'package:doc_connect/utils/covid_widgets/covid_warn.dart';
import 'package:doc_connect/utils/covid_widgets/forum.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key key}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    final forumsProvider = Provider.of<ForumsProvider>(context);
    final doctorData = Provider.of<DoctorDataProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 4.0),
            CovidWarn(),

            ///----------- forums
            _getForums(doctorData, forumsProvider),

            /// ----
            /// --- show nearby patients
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Text(
                    'Patients nearby',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
//                    Navigator.of(context)
//                        .push(AppNavigation.route(ViewAllForums()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('View all'),
                  ),
                ),
                SizedBox(width: 8.0)
              ],
            ),

            doctorData.nearbyPatients.length > 0
                ? UserWidget(
                    user: doctorData.nearbyPatients[0],
                  )
                : SizedBox(
                    child: Center(
                      child: Text('No nearby patients here'),
                    ),
                  ),

            doctorData.nearbyPatients.length > 1
                ? UserWidget(
                    user: doctorData.nearbyPatients[1],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  /// ----------- get forums
  Widget _getForums(
      DoctorDataProvider dataProvider, ForumsProvider forumsProvider) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      color: Color(0xfffbf4d9),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: Text(
                    'Forums',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(AppNavigation.route(ViewAllQuestions()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('View all'),
                  ),
                ),
                SizedBox(width: 8.0)
              ],
            ),
            SizedBox(
              height: 8.0,
            ),

            /// --- show two forums
            forumsProvider.forums.length > 0
                ? ForumWidget(
                    forum: forumsProvider.forums[0],
                  )
                : SizedBox(
                    child: Center(
                      child: Text('No forums added yet'),
                    ),
                  ),
            forumsProvider.forums.length > 1
                ? ForumWidget(
                    forum: forumsProvider.forums[1],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
