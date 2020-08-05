import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/chat_user.dart';
import 'package:doc_connect/data_models/message.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalDB {
  bool _initialized = false;

  static Box chatsBox;
  static Box messagesBox;

  Future<void> init() async {
    // init local db
    if (!_initialized) {
      debugPrint("Initialising local db");
      _initialized = true;
      final appDocumentDir =
          await path_provider.getApplicationDocumentsDirectory();
      await Hive.init(appDocumentDir.path);

      Hive.registerAdapter(ChatAdapter());
      Hive.registerAdapter(ChatUserAdapter());
      Hive.registerAdapter(MessageAdapter());

      chatsBox = await Hive.openBox(Constants.chatBox);
      messagesBox = await Hive.openBox(Constants.messagesBox);

      // Pulling and storing data from local
      ChatService()..pullLocalMessagesAndChats();
    } else {
      debugPrint("Local db already initialised");
    }
  }
}
