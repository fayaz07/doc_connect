import 'package:covid19doc/data_models/forum.dart';
import 'package:flutter/cupertino.dart';

class CurrentForumData with ChangeNotifier {
  ForumQuestion _forum;
  String _authorGender, _authorAge, _location;

  String get authorGender => _authorGender;

  set authorGender(String value) {
    _authorGender = value;
    notifyListeners();
  }

  ForumQuestion get forum => _forum;

  set forum(ForumQuestion value) {
    _forum = value;
    notifyListeners();
  }

  addMessage(ForumMessage message) {
    forum.messages.add(message);
    forum.messages = forum.messages.toSet().toList(growable: true);
    forum = forum;
  }

  addAllAtEnd(List<ForumMessage> messages) {
    forum.messages.addAll(messages);
    forum.messages = forum.messages.toSet().toList(growable: true);
    forum = forum;
  }

  addAll(List<ForumMessage> messages){
    forum.messages = messages.toSet().toList(growable: true);
    forum = forum;
  }

  addAllAtBeginning(List<ForumMessage> messages) {
    messages.addAll(forum.messages);
    forum.messages = messages.toSet().toList(growable: true);
    forum = forum;
  }

  get authorAge => _authorAge;

  set authorAge(value) {
    _authorAge = value;
    notifyListeners();
  }

  get location => _location;

  set location(value) {
    _location = value;
    notifyListeners();
  }

  reset({ForumQuestion forum}) {
    location = " ";
    authorAge = " ";
    authorGender = " ";
    this.forum = forum ??
        ForumQuestion(
          solved: false,
        );
  }
}
