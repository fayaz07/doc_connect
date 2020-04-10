import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19doc/api/utils/urls.dart';
import 'package:covid19doc/data_models/chat.dart';
import 'package:covid19doc/providers/chat.dart';
import 'package:covid19doc/providers/user.dart';
import 'package:covid19doc/utils/constants.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  final InboxModel inboxModel;

  const ChatScreen({
    Key key,
    this.inboxModel,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Socket _chatSocket;
  String authorId = " ";

  @override
  void initState() {
    super.initState();
    initSockets();
  }

  initSockets() async {
    _chatSocket = io(Urls.chatsNSP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'chat_id': widget.inboxModel.chat.id} // optional
    });

    ///------------ check on connection
    _chatSocket.on('connect', (data) {
      print('connected');
    });

//    await Future.delayed(Duration(milliseconds: 50));

    final provider = Provider.of<ChatProvider>(context, listen: false);

    ///------------ listen to old messages
    _chatSocket.on('old_messages', (old_messages) {
      if (old_messages.length > 0) {
        List<Message> list = [];
        for (var c in old_messages) {
          list.add(Message.fromJSON(c));
        }
        provider.currentChatMessages = list;

        try {
          Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.linear);
          });
        } catch (err) {}
      }
    });

    ///------------ listen to messages
    _chatSocket.on('new_message', (message) {
      if (message['author_id'].toString().trim() == authorId.trim()) {
        // my own message and it is already added to the tree, so don't add it to the tree now
      } else {
        provider.addCurrentChatMessage(Message.fromJSON(message));
        try {
          Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
            scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut);
          });
        } catch (err) {}
      }
    });

    ///------------ check on disconnection
    _chatSocket.on('disconnect', (data) {
      print('disconnected');
    });
  }

  @override
  void dispose() {
    _chatSocket.disconnect();
    super.dispose();
  }

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    authorId = userProvider.user.id;
    return Scaffold(
      backgroundColor: Color(0xfffbf4d9),
      appBar: MyAppbar(
        handleGoBack: () {
          Navigator.of(context).pop();
        },
        title: '${widget.inboxModel.name}',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          key: Key('show-Messages'),
          controller: scrollController,
          itemCount: chatProvider.currentChatMessages.length,
          itemBuilder: (context, i) => MessageBuilder(
              message: chatProvider.currentChatMessages[i],
              url: widget.inboxModel.photo_url),
        ),
      ),
      bottomSheet: getSendMessageField(userProvider, chatProvider),
    );
  }

  TextEditingController _textEditingController = TextEditingController();

  Widget getSendMessageField(
      UserProvider userProvider, ChatProvider chatProvider) {
    return Material(
      color: Color(0xfffbf4d9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          key: Key('sendMessageField'),
          children: <Widget>[
            /// text-field
            Expanded(
              key: Key('textField'),
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextFormField(
                        controller: _textEditingController,
                        maxLines: null,
                        showCursor: true,
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.text,
                        maxLengthEnforced: false,
                        cursorWidth: 3.0,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: 'Type your message here..',
                            contentPadding: EdgeInsets.only(
                                bottom: 15.0,
                                left: 20.0,
                                right: 20.0,
                                top: 10.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.orangeAccent.withOpacity(0.4)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))))),
                  )),
            ),

            /// send button
            CupertinoButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () => buildNewMessage(userProvider, chatProvider),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Icon(Icons.send, color: Colors.white, size: 22.0),
              ),
            ),
            SizedBox(width: 10.0)
          ],
        ),
      ),
    );
  }

  buildNewMessage(UserProvider userProvider, ChatProvider chatProvider) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_textEditingController.text.length > 0) {
      final message = Message(
        room_id: widget.inboxModel.chat.id,
        message: _textEditingController.text.trim(),
        author:
            userProvider.user.first_name + " " + userProvider.user.last_name,
        author_id: userProvider.user.id,
      );
      final messageJson = Message.toJSON(message);

      // adding message to tree
      chatProvider.addCurrentChatMessage(message);

      try {
        Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        });
      } catch (err) {}

      _textEditingController.text = "";
      // sending it to server
      _chatSocket.emit(
        'send_message',
        messageJson,
      );
    }
  }
}

class MessageBuilder extends StatelessWidget {
  final Message message;
  final String url;

  const MessageBuilder({Key key, this.message, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundImage: CachedNetworkImageProvider(
              url == null || url.length < 5
                  ? Constants.defaultProfilePic
                  : Urls.host + url,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${message.author}',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${message.message}',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
