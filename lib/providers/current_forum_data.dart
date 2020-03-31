import 'package:covid19doc/data_models/forum.dart';
import 'package:flutter/cupertino.dart';

class CurrentForumData with ChangeNotifier {
  Forum _forum;

  Forum get forum => _forum;

  set forum(Forum value) {
    _forum = value;
    notifyListeners();
  }

  addMessage(Message message) {
    forum.messages.add(message);
    forum.messages = forum.messages.toSet().toList(growable: true);
    forum = forum;
  }

  addAllAtEnd(List<Message> messages) {
    forum.messages.addAll(messages);
    forum.messages = forum.messages.toSet().toList(growable: true);
    forum = forum;
  }

  addAllAtBeginning(List<Message> messages) {
    messages.addAll(forum.messages);
    forum.messages = messages.toSet().toList(growable: true);
    forum = forum;
  }
}
