import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/forum/forum_detailed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumQuestionTile extends StatelessWidget {
  final String forumId;
  final int id;

  const ForumQuestionTile({Key key, this.forumId, this.id}) : super(key: key);

  void forumDetailed(BuildContext context) {
    Provider.of<ForumsService>(context, listen: false).fetchResponses(forumId);
    Navigator.of(context).push(
      AppNavigation.route(
        ForumDetailed(
          forumQuestionId: forumId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final forum = Provider.of<ForumsService>(context).forumQuestions[forumId];
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () => forumDetailed(context),
      child: Container(
        width: 240.0,
        decoration: BoxDecoration(
          color: AppColors.cardColors[16 % id],
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${forum.question.substring(0, 50)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Related to: ${forum.topic}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              'Patient age: ${forum.author.age} ${forum.author.gender}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ForumQuestionWidget extends StatelessWidget {
  final String forumId;
  final int id;

  const ForumQuestionWidget({Key key, this.forumId, this.id}) : super(key: key);

  void forumDetailed(BuildContext context) {
    Provider.of<ForumsService>(context, listen: false).fetchResponses(forumId);
    Navigator.of(context).push(
      AppNavigation.route(
        ForumDetailed(
          forumQuestionId: forumId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final forum = Provider.of<ForumsService>(context).forumQuestions[forumId];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 4.0),
      color: AppColors.cardColors[28 % id],
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () => forumDetailed(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                forum.title ?? " ",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.0),
              Text(
                forum.question.substring(0, 100) + "..." ?? " ",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                "Patient age: ${forum.author.age} ${forum.author.gender}",
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 4.0),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "${forum.views.length ?? 0}",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "${forum.upVotes.length ?? 0}",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Icon(
                    Icons.thumb_down,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "${forum.downVotes.length ?? 0}",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Spacer(),
                  forum.solved ? solved : SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final solved = Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    Material(
      type: MaterialType.circle,
      child: Icon(
        Icons.check_circle,
        size: 24.0,
        color: Colors.green.withOpacity(0.8),
      ),
      color: Colors.white,
    ),
    SizedBox(width: 8.0),
    Text(
      'Solved',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    )
  ],
);
