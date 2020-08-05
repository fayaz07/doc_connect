import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/message.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/views/chat/chat_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({Key key, this.chat}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
//    print(widget.chat);
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      disposeViewModel: true,
      viewModelBuilder: () => ChatScreenViewModel(),
      onModelReady: (m) => m.init(context, widget.chat),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 2.0,
          title: Text(
            '${widget.chat.users[0].firstName}',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: model.receivedOldMessages
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 64.0),
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                        physics: ScrollPhysics(),
                        key: Key('show-Messages'),
                        controller: model.scrollController,
                        itemCount: model.messages.length,
                        itemBuilder: (context, i) => MessageBuilder(
                            id: model.user.id,
                            message: model.messages[i],
                            url: widget.chat.users[0].photoUrl),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
//              height: 50.0,
              child: MessageInput(
                onMessageFieldTap: model.onMessageFieldTap,
                sendMessage: model.sendMessage,
                textEditingController: model.textEditingController,
              ),
            )
          ],
        ),
//        bottomSheet: ,
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback onMessageFieldTap;
  final VoidCallback sendMessage;

  const MessageInput(
      {Key key,
      this.textEditingController,
      this.onMessageFieldTap,
      this.sendMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
        child: Row(
          children: <Widget>[
            /// text-field
            Expanded(
              key: const Key('textField'),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300.0),
                child: TextField(
                  controller: textEditingController,
                  maxLines: null,
                  autofocus: false,
                  onTap: onMessageFieldTap,
                  showCursor: true,
                  cursorColor: Colors.blue,
                  keyboardType: TextInputType.text,
                  maxLengthEnforced: false,
                  cursorWidth: 3.0,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Type your message here..',
                    contentPadding: EdgeInsets.only(
                        bottom: 15.0, left: 20.0, right: 20.0, top: 10.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.orangeAccent.withOpacity(0.4)),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.0),

            /// send button
            CupertinoButton(
              padding: EdgeInsets.all(0.0),
              onPressed: sendMessage,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                child: Icon(Icons.send, color: Colors.white, size: 24.0),
              ),
            ),
            SizedBox(width: 8.0)
          ],
        ),
      ),
    );
  }
}

class MessageBuilder extends StatelessWidget {
  final Message message;
  final String url;
  final String id;

  const MessageBuilder({Key key, this.message, this.url, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return id.contains(message.authorId.trim())
        ? OutgoingText(
            image: url ?? Constants.defaultProfilePic,
            message: message,
          )
        : IncomingText(
            image: url ?? Constants.defaultProfilePic,
            message: message,
          );
  }
}

final Color incomingTextBackgroundColor = Colors.purpleAccent;
final Color outgoingTextBackgroundColor = Colors.indigoAccent;

class IncomingText extends StatelessWidget {
  final String image;
  final Message message;

  const IncomingText({Key key, this.image, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 50.0,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * .75),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(left: 49.0),
//                child: Text(
//                  '${message.authorId}',
//                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
//                ),
//              ),
//              SizedBox(height: 2.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  SizedBox(width: 8.0),
//                  CircleAvatar(
//                    radius: 16.0,
//                    backgroundImage: CachedNetworkImageProvider(image),
//                  ),
//                  SizedBox(width: 8.0),
                  Flexible(
                    flex: 2,
                    child: Material(
                      color: incomingTextBackgroundColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                              topLeft: Radius.circular(4.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '${message.message}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '${message.time.hour}:${message.time.minute}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OutgoingText extends StatelessWidget {
  final String image;
  final Message message;

  const OutgoingText({Key key, this.image, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Align(
        alignment: Alignment.topRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 50.0,
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * .75),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Material(
                  color: outgoingTextBackgroundColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                          topRight: Radius.circular(4.0),
                          topLeft: Radius.circular(16.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '${message.message}',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '${message.time.hour}:${message.time.minute}',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//              SizedBox(width: 8.0),
//              CircleAvatar(
//                radius: 16.0,
//                backgroundImage: CachedNetworkImageProvider(image),
//              ),
//              SizedBox(width: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
