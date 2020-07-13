import 'package:doc_connect/views/forum/ask_in_forum_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:doc_connect/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class AskInForum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AskInForumViewModel>.reactive(
      viewModelBuilder: () => AskInForumViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text('Ask your question',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.pop,
          ),
        ),
        body: SingleChildScrollView(
          child: _questionForm(model),
        ),
      ),
    );
  }

  final padding = EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 8.0);

  Widget _questionForm(AskInForumViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: model.askQuestionFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 32.0),
            TitleText(title: 'Please fill out this form to post your question'),
            SizedBox(height: 8.0),
            OutlinedTextField(
              label: 'Title',
              hint: 'What is your question',
              padding: padding,
              validateLength: 5,
              maxLength: 50,
              save: (value) => model.question.title = value,
            ),
            OutlinedTextField(
              label: 'Description',
              hint: 'Briefly describe your question',
              maxLines: 8,
              padding: padding,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              validateLength: 120,
              maxLength: 1200,
              save: (value) => model.question.question = value,
            ),
            OutlinedTextField(
              label: 'Topic',
              hint: 'Ex: Heart (or) Health (or) Flu...',
              padding: padding,
              validateLength: 3,
              maxLength: 20,
              save: (value) => model.question.topic = value,
            ),
            SizedBox(height: 32.0),
            AppPlatformButton(
              text: 'SUBMIT',
              height: 50.0,
              width: double.infinity,
              borderRadius: 32.0,
              color: Colors.greenAccent,
              onPressed: model.validateForm,
            )
          ],
        ),
      ),
    );
  }
}
