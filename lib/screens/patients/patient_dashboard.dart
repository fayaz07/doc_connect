import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/providers/patient_data.dart';
import 'package:covid19doc/screens/forum/view_all_forums.dart';
import 'package:covid19doc/utils/covid_widgets/covid_warn.dart';
import 'package:covid19doc/utils/covid_widgets/forum.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PatientDashboard extends StatefulWidget {
  final PatientDataProvider dataProvider;

  const PatientDashboard({Key key, this.dataProvider}) : super(key: key);

  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    final forumsProvider = Provider.of<ForumsProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 4.0),
            CovidWarn(),

            ///----------- forums
            _getForums(widget.dataProvider, forumsProvider),
          ],
        ),
      ),
    );
  }

  /// ----------- get forums
  Widget _getForums(
      PatientDataProvider dataProvider, ForumsProvider forumsProvider) {
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
                        .push(AppNavigation.route(ViewAllForums()));
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
