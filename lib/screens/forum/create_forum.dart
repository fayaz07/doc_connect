import 'package:covid19doc/api/forum.dart';
import 'package:covid19doc/data_models/forum.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/providers/forums.dart';
import 'package:covid19doc/utils/dialogs/dialogs.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/platform_widgets.dart';
import 'package:covid19doc/utils/widgets/text_field_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CreateForum extends StatefulWidget {
  @override
  _CreateForumState createState() => _CreateForumState();
}

class _CreateForumState extends State<CreateForum> {
  Forum forum = Forum();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        handleGoBack: (){
          Navigator.of(context).pop();
        },
        title: 'New Forum',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16.0),
                WrappedTextFieldWithCard(
                  label: 'Name of the forum',
                  validateLength: 2,
                  save: (value) => forum.title = value.trim(),
                ),
                WrappedTextFieldWithCard(
                  label:
                      'Some info about what discussions happen in this forum',
                  validateLength: 20,
                  maxLines: 6,
                  save: (value) => forum.description = value.trim(),
                ),
                SizedBox(height: 16.0),
                EnableDisableButton(
                  text: 'SUBMIT',
                  enabled: true,
                  onPressed: createNewForum,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createNewForum() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    Result result = await ForumAPI.createForum(forum);
    if (result.success) {
      Provider.of<ForumsProvider>(context, listen: false).addForum(result.data);
      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: 'Forum added',
          buttonText: 'GO BACK',
          onPressed: () {
            /// hide dialog
            Navigator.of(context).pop();

            /// pop current screen
            Navigator.of(context).pop();
          },
          content:
              'A new froum has been created successfully! Thank you for contributing',
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
  }
}
