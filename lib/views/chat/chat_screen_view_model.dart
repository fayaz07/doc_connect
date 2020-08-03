import 'package:doc_connect/api/urls.dart';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

final messageFieldFN = FocusNode(debugLabel: 'chat-screen-tf');

class ChatScreenViewModel extends ChangeNotifier {
  final scrollController = ScrollController(keepScrollOffset: true);
  final TextEditingController textEditingController = TextEditingController();
  BuildContext _context;
  Chat _chat = Chat();
  bool _receivedOldMessages = false;
  Socket _chatSocket;
  final FocusNode messageFieldFocusNode = FocusNode();
  bool _firstMessage = true;

  void init(BuildContext context, Chat chat) {
    _context = context;
    _chat = chat;
    _firstMessage = true;
    _initSockets(chat);
  }

  _initSockets(Chat chat) async {
    _chatSocket = io(Urls.chatsNSP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'chat_id': chat.id} // optional
    });

    ///------------ check on connection
    _chatSocket.on('connect', (data) {
      print('connected');
    });

    ///------------ listen to old messages
    _chatSocket.on('old_messages', (oldMessages) {
      if (oldMessages.length > 0) {
        List<Message> list = List<Message>();
        for (var c in oldMessages) {
          list.add(Message.fromJSON(c));
        }
        Provider.of<ChatService>(_context, listen: false)
            .addAllMessages(_chat.id, list);
        receivedOldMessages = true;
        try {
          Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
            scrollController
                .animateTo(scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc)
                .whenComplete(() => scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc));
          });
        } catch (err) {}
      }
    });

    ///------------ listen to new messages
    _chatSocket.on('new_message', (newMessage) {
      if (newMessage['author_id'].toString().trim() == user.id.trim()) {
        // my own message and it is already added to the tree,
        // so don't add it to the tree now

        // update the id of the message
        Provider.of<ChatService>(_context, listen: false)
            .updateLastMessage(_chat.id, Message.fromJSON(newMessage));
      } else {
        final parsedNewMessage = Message.fromJSON(newMessage);
        Provider.of<ChatService>(_context, listen: false)
            .addMessage(_chat.id, parsedNewMessage);
        try {
          Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCirc);
//            print('scrolled to end');
          });
        } catch (err) {
          print(err);
        }
      }
    });

    ///------------ check on disconnection
    _chatSocket.on('disconnect', (data) {
      print('disconnected');
    });
  }

  void onMessageFieldTap() {
//    try {
//      Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
//        scrollController.animateTo(scrollController.position.maxScrollExtent,
//            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
//      });
//    } catch (err) {}
  }

  void sendMessage() {
    if (textEditingController.text.length > 0) {
      var message = Message(
        roomId: _chat.id,
        message: textEditingController.text.trim(),
        authorId: user.id,
      );
      var messageJson = Message.toJSON(message);
      message.time = DateTime.now();

      if (_firstMessage) {
        _firstMessage = false;
        messageJson['first'] = true;
        messageJson['target'] = _chat.users[0].userId;
//        debugPrint("----------------first message--------------");
      }

      // adding message to tree
      Provider.of<ChatService>(_context, listen: false)
          .addMessage(_chat.id, message);

      textEditingController.text = "";

      try {
        Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        });
      } catch (err) {
        print(err);
      }

      // sending it to server
      _chatSocket.emit(
        'send_message',
        messageJson,
      );
    }
  }

  User get user => _context == null
      ? User()
      : Provider.of<UsersService>(_context, listen: false).user;

  List<Message> get messages => _context == null
      ? List<Message>()
      : Provider.of<ChatService>(_context).messages[_chat.id] ??
          List<Message>();

  bool get receivedOldMessages => _receivedOldMessages;

  set receivedOldMessages(bool value) {
    _receivedOldMessages = value;
    notifyListeners();
  }

  @override
  void dispose() {
//    if (FocusScope.of(_context).focusedChild == messageFieldFN) {
//      FocusScope.of(_context).requestFocus(FocusNode());
//      print("has focus");
//      return Future.value(false);
//    }
    super.dispose();
    _chatSocket.close();
//    return Future.value(true);
  }
}
