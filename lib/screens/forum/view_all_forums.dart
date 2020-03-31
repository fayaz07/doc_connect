import 'package:covid19doc/providers/auth.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/utils/covid_widgets/forum.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'create_forum.dart';

class ViewAllForums extends StatefulWidget {
  @override
  _ViewAllForumsState createState() => _ViewAllForumsState();
}

class _ViewAllForumsState extends State<ViewAllForums> {
  @override
  Widget build(BuildContext context) {
    final forumsProvider = Provider.of<ForumsProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: MyAppbar(
        title: 'Forums',
        handleGoBack: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: forumsProvider.forums.length,
          itemBuilder: (context, i) {
            return ForumWidget(forum: forumsProvider.forums[i]);
          },
        ),
      ),
      floatingActionButton: authProvider.auth.isDoctor
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(AppNavigation.route(CreateForum()));
              },
              child: Icon(Icons.add_comment),
            )
          : SizedBox(),
    );
  }
}
