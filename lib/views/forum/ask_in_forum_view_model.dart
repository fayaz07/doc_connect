import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class AskInForumViewModel extends ChangeNotifier {
  BuildContext _context;
  final askQuestionFormKey = GlobalKey<FormState>();
  ForumQuestion _question = ForumQuestion();

  init(BuildContext context) {
    _context = context;
  }

  Future<void> validateForm() async {
    if (!askQuestionFormKey.currentState.validate()) {
      AppToast.show(text: "Please fill the form with valid inputs");
      return;
    }
    showLoader(isModal: true);
    askQuestionFormKey.currentState.save();
    final Response response = await APIService.api
        .askQuestionInForum(jsonEncode(ForumQuestion.toJSONForNewQuestion(question)));
    hideLoader();
    if (response.isSuccessful) {
      final newQuestion =
          ForumQuestion.fromJSON(json.decode(response.body)["forum"]);
      Provider.of<ForumsProvider>(_context, listen: false)
          .forumQuestions[newQuestion.id] = newQuestion;
      pop();
    } else {
      AppToast.showError(response);
    }
  }


  void pop() {
    Navigator.of(_context).pop();
  }

  ForumQuestion get question => _question;

  set question(ForumQuestion value) {
    _question = value;
    notifyListeners();
  }
}
