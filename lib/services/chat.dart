import 'dart:convert';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/message.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/local_db.dart';
import 'package:doc_connect/services/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:dartx/dartx.dart';

class ChatService with ChangeNotifier {
  static Map<String, Chat> _chats = Map();
  static Map<String, List<Message>> _messages = Map();

  bool _hasError = false;
  bool _loaded = false;

  void _updateChatsToHiveBox(Chat chat) {
    LocalDB.chatsBox.put(chat.id, chat);
  }

  void _updateAllChatsToHiveBox(Map<String, Chat> map) {
    LocalDB.chatsBox.putAll(map);
  }

  void _updateMessagesToHiveBox(String chatId, List<Message> messages) {
    LocalDB.messagesBox.put(chatId, messages);
  }

  Future<void> pullLocalMessagesAndChats() async {
    debugPrint("Pulling messages from localdb");

    LocalDB.chatsBox.keys.forEach((element) {
      _chats[element] = LocalDB.chatsBox.get(element);
    });

//    print(_chats);

//    debugPrint(LocalDB.messagesBox.keys.length.toString());
    LocalDB.messagesBox.keys.forEach((key) {
      _messages[key] = List<Message>.from(
          LocalDB.messagesBox.get(key, defaultValue: <Message>[]));
    });

//    print(_messages);
    notifyListeners();
    return;
  }

  /// Messages go here
  void updateLastMessage(String chatId, Message message) {
    List<Message> list = _messages[chatId];
    list.removeLast();
    list.add(message);
//    _messagesMap.update(chatId, (value) => list);
    _updateMessagesToHiveBox(chatId, list);
    notifyListeners();
  }

  void addMessage(String chatId, Message message) {
    _messages.update(chatId, (List<Message> messages) {
      if (messages == null) messages = List<Message>();
      messages.add(message);
      _updateMessagesToHiveBox(chatId, messages);
      return messages;
    }, ifAbsent: () {
      List<Message> messages = [];
      messages.add(message);
      _updateMessagesToHiveBox(chatId, messages);
      return messages;
    });
    notifyListeners();
  }

  void addAllMessages(String chatId, List<Message> newMessages) {
    _messages.update(chatId, (List<Message> messages) {
      if (messages == null) messages = <Message>[];
      messages.addAll(newMessages);
      messages = messages
          .distinctBy((element) => element.id)
          .sortedBy((element) => element.time)
          .toList();
      _updateMessagesToHiveBox(chatId, messages);
      return messages;
    }, ifAbsent: () {
      List<Message> messages = <Message>[];
      messages.addAll(newMessages);
      messages = messages
          .distinctBy((element) => element.id)
          .sortedBy((element) => element.time)
          .toList();
      _updateMessagesToHiveBox(chatId, messages);
      return messages;
    });
    notifyListeners();
  }

  /// Chats go here
  Future<void> fetchChats(BuildContext context) async {
    if (chats.length > 0) {
      _loaded = true;
      notifyListeners();
    }
    if (!_loaded) {
      final response = await APIService.api.getChats();
      if (response.isSuccessful) {
        final currUserId =
            Provider.of<UsersService>(context, listen: false).user.id;
        final _parsedMap =
            Chat.parseAsMap(json.decode(response.body)["chats"], currUserId);

        _chats.addAll(_parsedMap);
        _updateAllChatsToHiveBox(_parsedMap);

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
//    chatsBox.put(chat.id, chat);
    _updateChatsToHiveBox(chat);
    notifyListeners();
  }

  void markChatAsAccepted(String chatId) {
    _chats.update(chatId, (Chat chat) {
      chat.accepted = true;
      _updateChatsToHiveBox(chat);
      return chat;
    });

    notifyListeners();
  }

  void markChatAsRejected(String chatId) {
    _chats.update(chatId, (Chat chat) {
      chat.rejected = true;
      _updateChatsToHiveBox(chat);
      return chat;
    });
    notifyListeners();
  }

  /// Getters and setters
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

  Map<String, List<Message>> get messages => _messages;

  set messages(Map<String, List<Message>> value) {
    _messages = value;
    notifyListeners();
  }
}
