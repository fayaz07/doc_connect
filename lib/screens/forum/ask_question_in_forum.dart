import 'package:doc_connect/api/forum.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/providers/forums.dart';
import 'package:doc_connect/utils/dialogs/dialogs.dart';
import 'package:doc_connect/utils/widgets/app_bar.dart';
import 'package:doc_connect/utils/widgets/custom_drop_down_button.dart';
import 'package:doc_connect/utils/widgets/platform_widgets.dart';
import 'package:doc_connect/utils/widgets/text_field_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class AskQuestionInForum extends StatefulWidget {
  @override
  _AskQuestionInForumState createState() => _AskQuestionInForumState();
}

class _AskQuestionInForumState extends State<AskQuestionInForum> {
  ForumQuestion forum = ForumQuestion();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: MyAppbar(
          handleGoBack: () {
            Navigator.of(context).pop();
          },
          title: 'Ask question',
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    WrappedTextFieldWithCard(
                      label: 'Title',
                      validateLength: 2,
                      save: (value) => forum.title = value.trim(),
                    ),
                    WrappedTextFieldWithCard(
                      label: 'Explain your problem briefly',
                      validateLength: 20,
                      maxLength: 140,
                      maxLines: 5,
                      save: (value) => forum.question = value.trim(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: DropDownButton(
                        items: ['Heart', 'Cold', 'Cough', 'Fever', 'Other'],
                        title: 'Select topic',
                        onSelected: (topic) {
                          forum.topic = topic.toString();
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    EnableDisableButton(
                      text: 'SUBMIT',
                      enabled: true,
                      onPressed: askQuestion,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  askQuestion() async {
    if (forum.topic == null) {
      forum.topic = "Heart";
    }

    if (!formKey.currentState.validate()) return;
    showLoader();
    formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    Result result = await ForumAPI.createForum(forum);
    if (result.success) {
      Provider.of<ForumsProvider>(context, listen: false).addForum(result.data);
      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Question posted',
          buttonText: 'GO BACK',
          onPressed: () {
            /// hide dialog
            Navigator.of(context).pop();

            /// pop current screen
            Navigator.of(context).pop();
          },
          content:
              'Your question has been posted successfully, please wait for someone to respond',
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          title: 'Oops',
          content: result.message,
        ),
      );
    }
    hideLoader();
  }
}
