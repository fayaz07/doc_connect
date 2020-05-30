import 'package:covid19doc/providers/auth.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/utils/covid_widgets/forum.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'ask_question_in_forum.dart';

class ViewAllQuestions extends StatefulWidget {
  @override
  _ViewAllQuestionsState createState() => _ViewAllQuestionsState();
}

class _ViewAllQuestionsState extends State<ViewAllQuestions> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AppNavigation.route(AskQuestionInForum()));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
