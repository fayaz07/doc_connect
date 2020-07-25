import 'dart:convert';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/chat/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class ChatsListViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  Future<void> acceptChatRequest(Chat chat) async {
    showLoader(isModal: true);
    final response = await APIService.api
        .acceptChatRequest(jsonEncode({"chat_id": chat.id}));
    if (response.isSuccessful) {
      Provider.of<ChatService>(_context, listen: false)
          .markChatAsAccepted(chat.id);
    } else {
      AppToast.showError(response);
    }
    hideLoader();
  }

  Future<void> rejectChatRequest(Chat chat) async {
    showLoader(isModal: true);
    final response = await APIService.api
        .rejectChatRequest(jsonEncode({"chat_id": chat.id}));
    if (response.isSuccessful) {
      Provider.of<ChatService>(_context, listen: false)
          .markChatAsRejected(chat.id);
    } else {
      AppToast.showError(response);
    }
    hideLoader();
  }

  void enterChatScreen(Chat chat) {
    Navigator.of(_context).push(AppNavigation.route(ChatScreen(chat: chat)));
  }

  Map<String, Chat> get chats =>
      _context == null ? Map() : Provider.of<ChatService>(_context).chats;

  bool get hasError =>
      _context == null ? false : Provider.of<ChatService>(_context).hasError;

  bool get loaded =>
      _context == null ? false : Provider.of<ChatService>(_context).loaded;
}
