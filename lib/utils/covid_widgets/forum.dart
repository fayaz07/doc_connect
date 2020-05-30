import 'package:covid19doc/data_models/forum.dart';
import 'package:covid19doc/providers/current_forum_data.dart';
import 'package:covid19doc/screens/forum/forum_page.dart';
import 'package:covid19doc/utils/widgets/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumWidget extends StatelessWidget {
  final ForumQuestion forum;

  const ForumWidget({Key key, this.forum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffbf4d9),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () {
          // enter forum
          Provider.of<CurrentForumData>(context, listen: false).reset(forum: forum);
          Navigator.of(context).push(
            AppNavigation.route(
              ForumPage(forumQuestion: forum),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    forum.title ?? " ",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    forum.question ?? " ",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.forum, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
