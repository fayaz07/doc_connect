import 'dart:convert';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:dartx/dartx.dart';

class ChatService with ChangeNotifier {
  Map<String, Chat> _chats = Map();
  Map<String, List<Message>> _messagesMap = Map();

  bool _hasError = false;
  bool _loaded = false;

  ChatService(BuildContext context) {
    _fetchChats(context);
  }

  Future<void> _fetchChats(BuildContext context) async {
    if (!_loaded) {
      final response = await APIService.api.getChats();
      if (response.isSuccessful) {
        final currUserId =
            Provider.of<UsersService>(context, listen: false).user.id;
        final _parsedMap =
            Chat.parseAsMap(json.decode(response.body)["chats"], currUserId);
        _chats.addAll(_parsedMap);
        _loaded = true;
        _hasError = false;
//        debugPrint(_parsedMap.length.toString());
        notifyListeners();
        return;
      } else {
        hasError = true;
        notifyListeners();
        return;
      }
    } else {
      return;
    }
  }

  void addChat(Chat chat) {
    assert(chat != null);
    assert(chat.id != null);
    assert(chat.users != null && chat.users.length > 2);
    assert(chat.requestedBy != null);

    _chats[chat.id] = chat;
    notifyListeners();
  }

  void updateLastMessage(String chatId, Message message) {
    List<Message> list = _messagesMap[chatId];
    list.removeLast();
    list.add(message);
    _messagesMap.update(chatId, (value) => list);
    notifyListeners();
  }

  void addMessage(String chatId, Message message) {
    _messagesMap.update(chatId, (List<Message> messages) {
      if (messages == null) messages = List<Message>();
      messages.add(message);
      return messages;
    }, ifAbsent: () {
      List<Message> messages = [];
      messages.add(message);
      return messages;
    });
    notifyListeners();
  }

  void addAllMessages(String chatId, List<Message> newMessages) {
    _messagesMap.update(chatId, (List<Message> messages) {
      if (messages == null) messages = <Message>[];
      messages.addAll(newMessages);
      messages = messages
          .distinctBy((element) => element.id)
          .sortedBy((element) => element.time)
          .toList();
      return messages;
    }, ifAbsent: () {
      List<Message> messages = <Message>[];
      messages.addAll(newMessages);
      messages = messages
          .distinctBy((element) => element.id)
          .sortedBy((element) => element.time)
          .toList();
      return messages;
    });
    notifyListeners();
  }

  void markChatAsAccepted(String chatId) {
    _chats.update(chatId, (Chat chat) {
      chat.accepted = true;
      return chat;
    });
    notifyListeners();
  }

  void markChatAsRejected(String chatId) {
    _chats.update(chatId, (Chat chat) {
      chat.rejected = true;
      return chat;
    });
    notifyListeners();
  }

  Map<String, Chat> get chats => _chats;

  set chats(Map<String, Chat> value) {
    _chats = value;
    notifyListeners();
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  bool get loaded => _loaded;

  set loaded(bool value) {
    _loaded = value;
    notifyListeners();
  }

  Map<String, List<Message>> get messages => _messagesMap;

  set messages(Map<String, List<Message>> value) {
    _messagesMap = value;
    notifyListeners();
  }
}
