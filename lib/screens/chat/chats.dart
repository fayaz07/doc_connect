import 'package:covid19doc/api/chat.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/providers/chat.dart';
import 'package:covid19doc/utils/configs.dart';
import 'package:covid19doc/utils/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    getInboxData();
    super.initState();
  }

  getInboxData() async {
    Result result = await ChatAPI.getChats();
    if (result.success) {
      Provider
          .of<ChatProvider>(context, listen: false)
          .inbox = result.data;
    } else {
      Provider
          .of<ChatProvider>(context, listen: false)
          .inboxError = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inboxProvider = Provider.of<ChatProvider>(context);

    if (inboxProvider.inboxLoading) return Center(child: Configs.loader);
    if (inboxProvider.inboxError)
      return Center(child: Text('Something has gone wrong'));
    if (inboxProvider.inbox.length == 0)
      return Configs.noResults;
    else if (inboxProvider.inbox.length > 0)
      return ListView.builder(
        itemCount: inboxProvider.inbox.length,
        itemBuilder: (BuildContext context, int i) =>
            ChatWidget(
              inboxModel: inboxProvider.inbox[i],
              index: i,
            ),
      );
    return Center(child: Configs.loader);
  }
}