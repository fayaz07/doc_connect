import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/forum/ask_in_forum.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AllForumViewModel extends ChangeNotifier {
  BuildContext _context;

  init(BuildContext context) {
    _context = context;
  }

  void fetchForums(BuildContext context) async{
    Provider.of<ForumsService>(context, listen: false)
        .fetchForums();
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  void askInForum() {
    Navigator.of(_context).push(AppNavigation.route(AskInForum()));
  }

  Map<String, ForumQuestion> get forumQuestions => _context == null
      ? Map<String, ForumQuestion>()
      : Provider.of<ForumsService>(_context).forumQuestions;

  Map<String, List<ForumMessage>> get forumMessages => _context == null
      ? Map<String, List<ForumMessage>>()
      : Provider.of<ForumsService>(_context).forumResponses;
}
