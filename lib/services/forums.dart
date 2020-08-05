import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//import 'package:dartx/dartx.dart';

class ForumsService with ChangeNotifier {
  static Map<String, ForumQuestion> _forumQuestions = Map();
  static Map<String, List<ForumMessage>> _forumResponses = Map();

  static bool _loading = false;

  void pullFromLocalDb() {
    if (LocalDB.forumQuestionsBox.length > 0) {
      LocalDB.forumQuestionsBox.keys.forEach((key) {
        _forumQuestions[key] =
            LocalDB.forumQuestionsBox.get(key, defaultValue: ForumQuestion());
      });
    }

    if (LocalDB.forumAnswersBox.length > 0) {
      LocalDB.forumAnswersBox.keys.forEach((key) {
        _forumResponses[key] = LocalDB.forumAnswersBox
            .get(key, defaultValue: List<ForumMessage>());
      });
    }

    notifyListeners();
  }

  Future<void> _addForumQuestionToLocalDB(ForumQuestion forumQuestion) async {
    await LocalDB.forumQuestionsBox.put(forumQuestion.id, forumQuestion);
  }

  Future<void> _addForumAnswerToLocalDB(
      String qid, List<ForumMessage> forumMessages) async {
    await LocalDB.forumAnswersBox.put(qid, forumMessages);
  }

  void parseForumQuestions(var decodedJson) {
    compute(ForumQuestion.parseAsMap, decodedJson["forums"])
        .then((Map<String, ForumQuestion> value) {
      //print(value);
      _forumQuestions.addAll(value);
      notifyListeners();
      _forumQuestions.forEach((key, value) {
        _addForumQuestionToLocalDB(value);
      });
    });
  }

  void addForum(ForumQuestion forumQuestion) {
    _forumQuestions[forumQuestion.id] = forumQuestion;
    _addForumQuestionToLocalDB(forumQuestion);
    notifyListeners();
  }

  Future<void> fetchResponses(String forumId) async {
    _loading = true;
    notifyListeners();
    final Response response = await APIService.api.getResponses(forumId);
    if (response.isSuccessful) {
      compute(ForumMessage.getResponsesFromList,
              json.decode(response.body)["responses"])
          .then((List<ForumMessage> value) {
        _forumResponses[forumId] = value;
        _addForumAnswerToLocalDB(forumId, value);
        _loading = false;
        notifyListeners();
      });
    } else {
      _loading = false;
      notifyListeners();
      AppToast.showError(response);
    }
  }

  Future<void> fetchForums() async {
    final response = await APIService.api.getForums();
    if (response.isSuccessful) {
      parseForumQuestions(json.decode(response.body));
    } else {
      AppToast.showError(response);
    }
  }

  Future<bool> addResponse(ForumMessage message) async {
//    print("Message dude $message");
    final response =
        await APIService.api.respond(jsonEncode(ForumMessage.toJSON(message)));
    if (response.isSuccessful) {
      List<ForumMessage> messages = _forumResponses[message.forumId];
      final sentResponse =
      ForumMessage.selfFromJSON(json.decode(response.body)["sent_message"]);
      message.id = sentResponse.id;
      if (messages == null) {
        messages = [message];
      } else {
        messages.add(message);
      }
      _forumResponses[message.forumId] = messages;
      _addForumAnswerToLocalDB(message.forumId, messages);
      notifyListeners();
    } else {
      AppToast.showError(response);
    }
    return response.isSuccessful;
  }

  Future<void> upVoteQ(String forumId) async {
    final response =
        await APIService.api.upVoteForumQ(jsonEncode({"id": forumId}));
    if (response.isSuccessful) {
      _forumQuestions[forumId].noOfUpVotes++;
      notifyListeners();
    } else {
      AppToast.showError(response);
    }
  }

  Future<void> downVoteQ(String forumId) async {
    final response =
        await APIService.api.downVoteForumQ(jsonEncode({"id": forumId}));
    if (response.isSuccessful) {
      _forumQuestions[forumId].noOfDownVotes++;
      notifyListeners();
    } else {
      AppToast.showError(response);
    }
  }

  Future<void> upVoteR(String questionId, String forumResponseId) async {
    final response =
        await APIService.api.upVoteForumR(jsonEncode({"id": forumResponseId}));
    if (response.isSuccessful) {
      _forumResponses[questionId].where((element) {
        if (element.id.contains(forumResponseId)) {
          element.upVotes.add(UniqueKey().toString());
          return true;
        }
        return false;
      });
      notifyListeners();
    } else {
      AppToast.showError(response);
    }
  }

  // todo: handle response upvotes & downvotes
  Future<void> downVoteR(String questionId, String forumResponseId) async {
    final response = await APIService.api
        .downVoteForumR(jsonEncode({"id": forumResponseId}));
    if (response.isSuccessful) {
      _forumResponses[questionId].where((element) {
        if (element.id.contains(forumResponseId)) {
          element.downVotes.add(UniqueKey().toString());
          return true;
        }
        return false;
      });
      notifyListeners();
    } else {
      AppToast.showError(response);
    }
  }

  ///-------------------------- Getters and setters ---------------------------
  Map<String, ForumQuestion> get forumQuestions => _forumQuestions;

  set forumQuestions(Map<String, ForumQuestion> value) {
    _forumQuestions = value;
    notifyListeners();
  }

  Map<String, List<ForumMessage>> get forumResponses => _forumResponses;

  set forumResponses(Map<String, List<ForumMessage>> value) {
    _forumResponses = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
