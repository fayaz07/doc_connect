import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/utils/widgets/navigation.dart';
import 'package:doc_connect/utils/widgets/text_field_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RespondInForum extends StatefulWidget {
  final Function(ForumMessage) sendResponse;

  const RespondInForum({Key key, this.sendResponse}) : super(key: key);

  @override
  _RespondInForumState createState() => _RespondInForumState();
}

class _RespondInForumState extends State<RespondInForum> {
  ForumMessage forumMessage = ForumMessage();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please respond with apporpriate answers as the responses will be public',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: WrappedTextFieldWithCard(
                    label: 'Answer',
                    validateLength: 20,
                    maxLength: 140,
                    maxLines: 5,
                    save: (value) => forumMessage.answer = value.trim(),
                  ),
                ),
                SizedBox(height: 4.0),
                WrappedTextFieldWithCard(
                  label: 'Tips',
                  validateLength: 0,
                  maxLength: 140,
                  maxLines: 5,
                  save: (value) => forumMessage.tips = value.trim(),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      if (!key.currentState.validate()) {
                        return;
                      }
                      key.currentState.save();
                      widget.sendResponse(forumMessage);
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'SEND',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
