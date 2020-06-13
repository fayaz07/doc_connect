import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/api/chat.dart';
import 'package:doc_connect/api/utils/urls.dart';
import 'package:doc_connect/data_models/chat.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/chat/chat_screen.dart';
import 'package:doc_connect/utils/configs.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/platform_widgets.dart';
import 'package:doc_connect/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class GuestProfile extends StatefulWidget {
  final User user;

  const GuestProfile({Key key, this.user}) : super(key: key);

  @override
  _GuestProfileState createState() => _GuestProfileState();
}

class _GuestProfileState extends State<GuestProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        handleGoBack: () {
          Navigator.of(context).pop();
        },
        title: ' ${widget.user.is_doctor ? "Doctor" : "Patient"} ',
      ),
      body: _getProfile(),
    );
  }

  _getProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: (widget.user.photo_url == null ||
                        widget.user.photo_url.length < 5)
                    ? Constants.defaultProfilePic
                    : Urls.host + widget.user.photo_url,
                placeholder: (context, data) => Configs.loader,
                height: 80.0,
                width: 80.0,
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 25.0,
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${widget.user.first_name} ${widget.user.last_name}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '${widget.user.is_doctor ? widget.user.speciality : widget.user.symptoms}',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),

          ///----- other profile details
          widget.user.is_doctor ? _getDoctor() : _getPatient(),
        ],
      ),
    );
  }

  _getPatient() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ProfileDetailTile(
          title: 'Symptoms',
          data: widget.user.symptoms ?? '-',
        ),
        ProfileDetailTile(
          title: 'Profession',
          data: widget.user.profession ?? '-',
        ),
        ProfileDetailTile(
          title: 'Location',
          data: widget.user.location ?? '-',
        ),
        ProfileDetailTile(
          title: 'Gender',
          data: widget.user.gender ?? '-',
        ),
//        EnableDisableButton(
//          color: Colors.green,
//          text: 'CHAT',
//          onPressed: initiateChat,
//        )
      ],
    );
  }

  _getDoctor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ProfileDetailTile(
          title: 'Speciality',
          data: widget.user.speciality ?? '-',
        ),
        ProfileDetailTile(
          title: 'Hosptial',
          data: widget.user.hospital_name ?? '-',
        ),
        ProfileDetailTile(
          title: 'Location',
          data: widget.user.location ?? '-',
        ),
        ProfileDetailTile(
          title: 'Gender',
          data: widget.user.gender ?? '-',
        ),
        SizedBox(height: 16.0),
        EnableDisableButton(
          color: Colors.green,
          text: 'CHAT',
          onPressed: initiateChat,
          enabled: true,
        )
      ],
    );
  }

  Future<void> initiateChat() async {
    String userId = Provider.of<UserProvider>(context, listen: false).user.id;
    showLoader();
    Result result = await ChatAPI.createOrGetChatId(userId, widget.user.id);
    hideLoader();
    if (result.success) {
      Chat res = result.data;
      if (res.accepted) {
        Navigator.of(context).push(
          AppNavigation.route(
            ChatScreen(
              inboxModel: InboxModel(
                chat: res,
                name: widget.user.first_name + " " + widget.user.last_name,
                photo_url: widget.user.photo_url,
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(
            title: 'Success',
            content:
                'You request to chat with the doctor has been successfully posted, please wait for the doctor to accept your request, meanwhile checkout chats section for your request approval',
          ),
        );
      }
//      Navigator.of(context).push(AppNavigation.route(ChatScreen()));
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          title: 'Oops',
          content: 'Something has gone wrong, please try later',
        ),
      );
    }
  }
}
