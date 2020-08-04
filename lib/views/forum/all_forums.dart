import 'package:doc_connect/views/forum/all_forum_view_model.dart';
import 'package:doc_connect/views/forum/forum_widgets.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class AllForums extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AllForumViewModel>.reactive(
      viewModelBuilder: () => AllForumViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Forums',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.pop,
          ),
          trailingActions: <Widget>[
            AppBarAction(
              buttonText: 'ask',
              onPressed: model.askInForum,
            ),
          ],
          material: (context, platform) => MaterialAppBarData(
            elevation: 4.0,
          ),
        ),
        body: _getForumQuestions(model),
      ),
    );
  }

  Widget _getForumQuestions(AllForumViewModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: model.forumQuestions.length,
      itemBuilder: (context, i) => ForumQuestionWidget(
        forumId: model.forumQuestions.keys.toList()[i],
        id: i + 1,
      ),
    );
  }
}

