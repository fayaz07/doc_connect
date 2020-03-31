import 'package:covid19doc/data_models/forum.dart';
import 'package:flutter/foundation.dart';

class ForumsProvider with ChangeNotifier {
  List<Forum> _forums = [];

  List<Forum> get forums => _forums;

  set forums(List<Forum> value) {
    _forums = value;
    notifyListeners();
  }

  addForum(Forum forum) {
    forums.add(forum);
    forums = forums;
  }

  addAMessageToForum(Message message, int index) {
    forums[index].messages.add(message);
    forums = forums;
  }

  /// ---------------------------
}
