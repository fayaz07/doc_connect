import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/views/forum/forum_detailed_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class ForumDetailed extends StatelessWidget {
  final String forumQuestionId;

  const ForumDetailed({Key key, this.forumQuestionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForumDetailedViewModel>.reactive(
      viewModelBuilder: () => ForumDetailedViewModel(),
      onModelReady: (m) => m.init(context, forumQuestionId),
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
              buttonText: 'respond',
              onPressed: model.respondInForum,
            ),
          ],
        ),
        body: _getBody(model),
      ),
    );
  }

  Widget _getBody(ForumDetailedViewModel model) {
    final responses = List.generate(
      model.responses.length,
      (index) =>
          ForumResponseWidget(response: model.responses[index], model: model),
    );

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        SizedBox(height: 4.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${model.question.title}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                '${model.question.question}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Related to: ${model.question.topic}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Patient age: ${model.question.author.age} ${model.question.author.gender}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Icon(
              Icons.remove_red_eye,
              color: Colors.grey,
            ),
            SizedBox(width: 4.0),
            Text("${model.question.noOfViews}"),
            SizedBox(width: 16.0),
            IconButton(
              onPressed: () => model.upVoteQ(),
              icon: Icon(
                Icons.thumb_up,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 4.0),
            Text("${model.question.noOfUpVotes}"),
            SizedBox(width: 16.0),
            IconButton(
              onPressed: () => model.downVoteQ(),
              icon: Icon(
                Icons.thumb_down,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 4.0),
            Text("${model.question.noOfDownVotes}"),
          ],
        )
      ]
        ..add(
          Divider(
            height: 32.0,
            thickness: 2.0,
          ),
        )
        ..add(TitleText(title: 'Responses'))
        ..add(SizedBox(height: 8.0))
        ..add(model.loading
            ? Center(child: CircularProgressIndicator())
            : responses.length == 0
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No responses yet',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )
                : SizedBox())
        ..addAll(responses),
    );
  }
}

class ForumResponseWidget extends StatelessWidget {
  final ForumMessage response;
  final ForumDetailedViewModel model;

  const ForumResponseWidget({Key key, this.response, this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print(response);
    return Card(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Solution",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              "${response.answer}",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              "Tips",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text("${response.tips}", style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => model.upVoteR(response.id),
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 4.0),
                Text("${response.upVotes?.length ?? 0}"),
                SizedBox(width: 16.0),
                IconButton(
                  onPressed: () => model.downVoteR(response.id),
                  icon: Icon(
                    Icons.thumb_down,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 4.0),
                Text("${response.downVotes?.length ?? 0}"),
                Spacer(),
                Row(
                  children: <Widget>[
                    Text(
                      'by: ${response.author.firstName} ${response.author.lastName}\n${response.author.profession ?? ""} ${response.author.speciality}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
