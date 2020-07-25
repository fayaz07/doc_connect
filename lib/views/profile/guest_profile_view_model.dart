import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class GuestProfileViewModel extends ChangeNotifier {
  BuildContext _context;
  User user = User();

  void init(BuildContext context, User guestUser) {
    _context = context;
    user = guestUser;
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  void handleCall() {
    if (user.availableForCall) {
      print('lets call');
    } else {
      print('not available');
    }
  }

  Future<void> handleChat() async {
    showLoader();
    final Response response =
        await APIService.api.createORGetChatRoomId(jsonEncode({
      "users": [
        Provider.of<UsersProvider>(_context, listen: false).user.id,
        user.id
      ]
    }));
    if (response.isSuccessful) {
      // got the chat model here
      final chat = json.decode(response.body)["chat"];
      Provider.of<ChatService>(_context, listen: false).addChat(chat);
    }
  }
}
