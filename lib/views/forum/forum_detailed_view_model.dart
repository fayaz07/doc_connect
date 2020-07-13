import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/views/forum/respond_in_forum.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ForumDetailedViewModel extends ChangeNotifier {
  BuildContext _context;
  String _forumQuestionId;

  init(BuildContext context, String questionId) {
    _context = context;
    _forumQuestionId = questionId;
    // logic here to check if responses were already loaded into the device
    // or show loader and load them from internet
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  void respondInForum() {
    Navigator.of(_context).push(
      AppNavigation.route(
        RespondInForum(
          forumId: _forumQuestionId,
        ),
      ),
    );
  }

  void upVoteQ(){
    Provider.of<ForumsProvider>(_context, listen: false)
        .upVoteQ(_forumQuestionId);
  }

  void downVoteQ(){
    Provider.of<ForumsProvider>(_context, listen: false)
        .downVoteQ(_forumQuestionId);
  }

  void upVoteR(String responseId){
    Provider.of<ForumsProvider>(_context, listen: false)
        .upVoteR(_forumQuestionId, responseId);
  }

  void downVoteR(String responseId){
    Provider.of<ForumsProvider>(_context, listen: false)
        .downVoteR(_forumQuestionId, responseId);
  }

  ForumQuestion get question => _context == null || _forumQuestionId == null
      ? ForumQuestion()
      : Provider.of<ForumsProvider>(_context).forumQuestions[_forumQuestionId];

  List<ForumMessage> _list = [];

  List<ForumMessage> get responses =>
      _context == null || _forumQuestionId == null
          ? _list
          : Provider.of<ForumsProvider>(_context)
                  .forumResponses[_forumQuestionId] ??
              _list;

  bool get loading =>
      _context == null ? true : Provider.of<ForumsProvider>(_context).loading;
}
