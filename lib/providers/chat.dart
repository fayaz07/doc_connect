import 'package:doc_connect/api/chat.dart';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  bool _inboxLoading = true, _inboxError = false;

  List<InboxModel> _inbox = [];

  List<InboxModel> get inbox => _inbox;

  set inbox(List<InboxModel> value) {
    _inbox = value;
    inboxLoading = false;
    notifyListeners();
  }

  updateInboxModelAndHideLoader(Chat chat, int index) {
    InboxModel removed = inbox.removeAt(index);
    removed.chat = chat;
    inbox.insert(index, removed);
    inbox = inbox;
    inboxLoading = false;
  }

  bool get inboxLoading => _inboxLoading;

  bool get inboxError => _inboxError;

  set inboxError(value) {
    _inboxError = value;
    notifyListeners();
  }

  set inboxLoading(bool value) {
    _inboxLoading = value;
    notifyListeners();
  }

  acceptChatRequest(InboxModel inboxModel, int index) async {
    inboxLoading = true;
    Result result = await ChatAPI.acceptChatRequest(inboxModel.chat.id);
    if (result.success) {
      updateInboxModelAndHideLoader(result.data, index);
    } else {
      inboxLoading = false;
    }
  }

  rejectChatRequest(InboxModel inboxModel, int index) async {
    inboxLoading = true;
    Result result = await ChatAPI.rejectChatRequest(inboxModel.chat.id);
    if (result.success) {
      updateInboxModelAndHideLoader(result.data, index);
    } else {
      inboxLoading = false;
    }
  }

  ///-------------------- current chat screen
  List<Message> _currentChatMessages = [];

  List<Message> get currentChatMessages => _currentChatMessages;

  set currentChatMessages(List<Message> value) {
    _currentChatMessages = value;
    notifyListeners();
  }

  addCurrentChatMessage(Message message) {
    currentChatMessages.add(message);
    currentChatMessages = currentChatMessages;
  }
}
