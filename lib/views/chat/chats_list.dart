import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/utils/colors.dart';
import 'package:doc_connect/views/chat/chats_list_view_model.dart';
import 'package:doc_connect/widgets/avatar.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class ChatsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChatsListViewModel>.reactive(
      viewModelBuilder: () => ChatsListViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) {
        final chatsList = model.chats.values.toList();
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(
              'Your inbox',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            material: (context, platform) =>
                MaterialAppBarData(elevation: 0.0, centerTitle: true),
          ),
          backgroundColor: Colors.white,
          body: !model.loaded
              ? Center(child: CircularProgressIndicator())
              : model.chats.length == 0
                  ? Center(
                      child: Text(model.hasError
                          ? 'Unable to load chats'
                          : 'No chats here'),
                    )
                  : ListView.builder(
                      itemCount: chatsList.length,
                      itemBuilder: (context, i) => ChatTile(
                        chat: chatsList[i],
                        accept: () => model.acceptChatRequest(chatsList[i]),
                        reject: () => model.rejectChatRequest(chatsList[i]),
                        enterChat: () => model.enterChatScreen(chatsList[i]),
                      ),
                    ),
        );
      },
    );
  }
}

class ChatTile extends StatelessWidget {
  final Chat chat;
  final VoidCallback enterChat, accept, reject;

  const ChatTile({Key key, this.chat, this.enterChat, this.accept, this.reject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: chat.rejected ? null : enterChat,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GetAvatar(
                  height: 58.0,
                  width: 58.0,
                  firstName: chat.users[0].firstName,
                  photoUrl: chat.users[0].photoUrl,
                ),
                SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      chat.users[0].firstName,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    chat.rejected
                        ? chat.requestedBySelf
                            ? Text(
                                'Your chat request has been rejected by the other user',
                                style: TextStyle(color: AppColors.infoColor),
                              )
                            : Text(
                                'You rejected the chat request',
                                style: TextStyle(),
                              )
                        : chat.accepted
                            ? Text('Tap here to message')
                            : chat.requestedBySelf
                                ? Text(
                                    'Your chat request has been sent',
                                    style:
                                        TextStyle(color: AppColors.infoColor),
                                  )
                                : Text(
                                    'Wants to start a conversation with you',
                                    style:
                                        TextStyle(color: AppColors.infoColor),
                                  ),
                    !chat.rejected && !chat.accepted && !chat.requestedBySelf
                        ? Row(
                            children: <Widget>[
                              AppPlatformButton(
                                width: 80.0,
                                height: 20.0,
                                borderRadius: 8.0,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                                color: AppColors.green,
                                onPressed: accept,
                                text: 'Accept',
                              ),
                              SizedBox(width: 8.0),
                              AppPlatformButton(
                                width: 80.0,
                                height: 20.0,
                                borderRadius: 8.0,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                                color: AppColors.danger,
                                onPressed: reject,
                                text: 'Reject',
                              ),
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
