import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ForumsProvider with ChangeNotifier {
  Map<String, ForumQuestion> _forumQuestions = Map();
  Map<String, List<ForumMessage>> _forumResponses = Map();

  bool _loading = false;

  parseForumQuestions(var decodedJson) {
    compute(ForumQuestion.parseAsMap, decodedJson["forums"])
        .then((Map<String, ForumQuestion> value) {
      print(value);
      _forumQuestions.addAll(value);
      notifyListeners();
    });
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
        _loading = false;
        notifyListeners();
      });
    } else {
      _loading = false;
      notifyListeners();
      AppToast.showError(response);
    }
  }

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

  Future<void> fetchForums() async {
    final response = await APIService.api.getForums();
    if (response.isSuccessful) {
      parseForumQuestions(json.decode(response.body));
    } else {
      AppToast.showError(response);
    }
  }

  Future<bool> addResponse(ForumMessage message) async {
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
}
