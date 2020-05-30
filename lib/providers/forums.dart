import 'package:covid19doc/data_models/forum.dart';
import 'package:flutter/foundation.dart';

class ForumsProvider with ChangeNotifier {
  List<ForumQuestion> _forums = [];

  List<ForumQuestion> get forums => _forums;

  set forums(List<ForumQuestion> value) {
    _forums = value;
    notifyListeners();
  }

  addForum(ForumQuestion forum) {
    forums.add(forum);
    forums = forums;
  }

  addAMessageToForum(ForumMessage message, int index) {
    forums[index].messages.add(message);
    forums = forums;
  }

  /// ---------------------------
}
