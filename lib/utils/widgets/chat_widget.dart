import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19doc/api/utils/urls.dart';
import 'package:covid19doc/data_models/chat.dart';
import 'package:covid19doc/providers/chat.dart';
import 'package:covid19doc/providers/user.dart';
import 'package:covid19doc/screens/chat/chat_screen.dart';
import 'package:covid19doc/utils/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../configs.dart';
import '../constants.dart';
import 'navigation.dart';

class ChatWidget extends StatelessWidget {
  final InboxModel inboxModel;
  final int index;

  const ChatWidget({Key key, this.inboxModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    return Container(
      width: double.infinity,
      //height: 140.0,
      color: Colors.white,
      margin: const EdgeInsets.only(top: Constants.fourBy1),
      padding: const EdgeInsets.all(Constants.sixteenBy1),
      child: InkWell(
        onTap: () {
          Provider.of<ChatProvider>(context, listen: false)
              .currentChatMessages = [];
          inboxModel.chat.accepted
              ? Navigator.of(context).push(
                  AppNavigation.route(
                    ChatScreen(inboxModel: inboxModel),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => WarningDialog(
                    title: 'Oops',
                    content: inboxModel.chat.requested_by.contains(userId)
                        ? 'You cannot chat with the person as he hasn\'t accepted your chat request'
                        : 'You cannot chat with the person as you have reject the chat request',
                    buttonText: 'OK',
                  ),
                );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                CachedNetworkImage(
                  height: 60.0,
                  width: 60.0,
                  imageUrl: inboxModel.photo_url == null
                      ? Constants.defaultProfilePic
                      : Urls.host + inboxModel.photo_url,
                  placeholder: (BuildContext context, String data) {
                    return Center(child: CircularProgressIndicator());
                  },
                  imageBuilder: (BuildContext context, ImageProvider image) {
                    return CircleAvatar(radius: 30.0, backgroundImage: image);
                  },
                ),
                SizedBox(width: Constants.sixteenBy1),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            inboxModel.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      (!inboxModel.chat.accepted && !inboxModel.chat.rejected) ?
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              !inboxModel.chat.accepted &&
                                  inboxModel.chat.requested_by
                                      .contains(userId)
                                  ? 'Your chat request was sent, please wait until doctor accepts it'
                                  : 'You have a chat request',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ) :
                      (inboxModel.chat.rejected
                          ? Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    inboxModel.chat.rejected &&
                                            inboxModel.chat.requested_by
                                                .contains(userId)
                                        ? 'Your chat request was rejected, you cannot chat'
                                        : 'You have rejected the chat request, you cannot chat',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    Configs.trimText(
                                        inboxModel.lastMessage, 100),
                                  ),
                                ),
                              ],
                            )),
                    ],
                  ),
                )
              ],
            ),
            !inboxModel.chat.accepted &&
                    !inboxModel.chat.rejected &&
                    !userId.contains(inboxModel.chat.requested_by.trim())
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 32.0,
                          color: Colors.green,
                        ),
                        onPressed: () async {
                          Provider.of<ChatProvider>(context, listen: false)
                              .acceptChatRequest(inboxModel, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 32.0,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          Provider.of<ChatProvider>(context, listen: false)
                              .rejectChatRequest(inboxModel, index);
                        },
                      ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
