import 'package:cached_network_image/cached_network_image.dart';
import 'package:doc_connect/api/utils/urls.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/providers/current_forum_data.dart';
import 'package:doc_connect/providers/session.dart';
import 'package:doc_connect/providers/user.dart';
import 'package:doc_connect/screens/forum/respond_forum.dart';
import 'package:doc_connect/utils/configs.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';


class ForumPage extends StatefulWidget {
  final ForumQuestion forumQuestion;

  const ForumPage({Key key, this.forumQuestion}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  /// receives forum-question id
  /// connects to socket-room
  ///   On-connection-response
  ///     fetches detail of user who posted the question
  ///     fetches responses/answers to the question
  ///   can-upVote
  ///     if already voted, removes vote
  ///   can-downVote
  ///     if already downVoted, removes downVote

  Socket _forumSocket;
  ScrollController scrollController = ScrollController();
  UserProvider userProvider;

  _initSockets() async {
    _forumSocket = io(Urls.forumsNSP, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'forumId': widget.forumQuestion.id,
        'authorid': widget.forumQuestion.authorId,
        'auth_token': Session.getAuthToken()
      } // optional
    });

    ///------------ check on connection
    _forumSocket.on('connect', (data) {
      print('connected to forum');
    });

    final provider = Provider.of<CurrentForumData>(context, listen: false);

    _forumSocket.on('user_data', (data) {
//      print(data);
      provider.authorGender = data["gender"] ?? "Male";
      provider.location = data["location"];
      provider.authorAge = data["age"].toString();
    });

    ///------------ listen to old messages
    _forumSocket.on('old_messages', (old_messages) {
      if (old_messages.length > 0) {
        List<ForumMessage> list = [];
        for (var c in old_messages) {
          list.add(ForumMessage.fromJSON(c));
        }
        provider.addAll(list);

//        try {
//          Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
//            scrollController.animateTo(
//                scrollController.position.maxScrollExtent,
//                duration: Duration(milliseconds: 100),
//                curve: Curves.linear);
//          });
//        } catch (err) {}
      }
    });

    ///------------ listen to messages
    _forumSocket.on('new_message', (message) {
      final newMessage = ForumMessage.fromJSON(message);
      if (newMessage.authorId == userProvider.user.id) return;
      provider.addMessage(newMessage);
      try {
        Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
        });
      } catch (err) {}
    });

    ///------------ check on disconnection
    _forumSocket.on('disconnect', (data) {
      print('disconnected from forum');
    });
  }

  @override
  void initState() {
    super.initState();
    _initSockets();
  }

  sendMessage(ForumMessage forumMessage) {
    forumMessage.authorId = userProvider.user.id;
    forumMessage.author =
        userProvider.user.first_name + " " + userProvider.user.last_name;
    forumMessage.forumId = widget.forumQuestion.id;
    forumMessage.profession = userProvider.user.profession ?? " ";
    forumMessage.speciality = userProvider.user.speciality ?? " ";
    forumMessage.doctor = userProvider.user.is_doctor;
    forumMessage.photoUrl = userProvider.user.photo_url;
    forumMessage.location = userProvider.user.location;
    forumMessage.answeredOn = DateTime.now();
    forumMessage.upVotes = [];
    forumMessage.downVotes = [];
    Provider.of<CurrentForumData>(context, listen: false)
        .addMessage(forumMessage);
    _forumSocket.emit('send_message', ForumMessage.toJSON(forumMessage));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrentForumData>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildQuestion(provider),
              ]
                ..add(SizedBox(height: 16.0))
                ..add(Text(' Responses', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700)))
                ..add(SizedBox(height: 4.0))
                ..addAll(_buildAnswers(provider))
                ..add(SizedBox(height: 60.0)),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: Colors.green,
          onPressed: () {
            Navigator.of(context).push(
              AppNavigation.route(
                RespondInForum(
                  sendResponse: sendMessage,
                ),
              ),
            );
          },
          child: SizedBox(
            height: 50.0,
            child: Center(
              child: Text(
                'RESPOND',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(CurrentForumData provider) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${provider.forum.title} ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '${provider.forum.question} ',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),

              /// patient details
              Row(
                children: <Widget>[
                  Text(
                    'Patient Age: ${provider.authorAge}, Gender: ${provider.authorGender}, ${provider.location}',
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              ),

              SizedBox(height: 4.0),

              /// topic and asked on
              Row(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        '${provider.forum.topic}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                      'Asked on: ${Configs.generalizedDate(provider.forum.askedOn)}'),
                ],
              ),

              /// Solution, views
              Row(
                children: <Widget>[
                  /// viewed times

                  Icon(
                    Icons.remove_red_eye,
                    color: Colors.black87,
                  ),
                  Text(' ${provider.forum.views.length} views'),

                  SizedBox(width: 8.0),

                  IconButton(
                    icon: Icon(Icons.thumb_up),
                  ),
                  Text('${provider.forum.upVotes.length}'),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                  ),
                  Text('${provider.forum.downVotes.length}'),

                  SizedBox(width: 8.0),

                  (provider.forum.solved)
                      ? FlatButton.icon(
                          padding: const EdgeInsets.all(4.0),
                          icon: Icon(
                            FontAwesomeIcons.checkCircle,
                            color: Colors.green,
                            size: 20.0,
                          ),
                          label: Text(
                            'Solved',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      );

  List<Widget> _buildAnswers(CurrentForumData provider) {
    List<Widget> widgets = [];
    provider.forum.messages.forEach((e) => widgets.add(_buildAnswer(e)));
    return widgets;
  }

  Widget _buildAnswer(ForumMessage message) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 24.0,
                    backgroundImage: CachedNetworkImageProvider(
                      message.photoUrl ?? Constants.defaultProfilePic,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${message.author}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      message.profession.length > 1
                          ? (message.speciality.length > 1
                              ? Text(
                                  '${message.profession}, ${message.speciality}',
                                )
                              : Text(
                                  '${message.profession}',
                                ))
                          : message.speciality.length > 1
                              ? Text(
                                  '${message.speciality}',
                                )
                              : SizedBox(),
                      Text(
                        '${message.location}',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text('${getTimeDifference(message.answeredOn)}',
                  style: TextStyle(color: Colors.grey)),
              SizedBox(height: 4.0),
              Text('Answer', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 2.0),
              Text('${message.answer}', style: TextStyle(color: Colors.black)),
              SizedBox(height: 8.0),
              Text('Tips', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 2.0),
              Text('${message.tips}', style: TextStyle(color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                  ),
                  Text('${message.upVotes.length}'),
                  IconButton(
                    icon: Icon(Icons.thumb_down),
                  ),
                  Text('${message.downVotes.length}'),
                  SizedBox(width: 8.0)
                ],
              )
            ],
          ),
        ),
      );

  String getTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    if (now.difference(dateTime).inMinutes > 59) {
      if (now.difference(dateTime).inHours > 24) {
        if (now.difference(dateTime).inDays > 30) {
          return " ${(now.difference(dateTime).inDays / 30).round()} months ago";
        } else {
          return " ${now.difference(dateTime).inDays} days ago";
        }
      } else {
        return " ${now.difference(dateTime).inHours} hours ago";
      }
    } else {
      return " ${now.difference(dateTime).inMinutes} minutes ago";
    }
  }
}
