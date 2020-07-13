import 'package:doc_connect/views/forum/respond_in_forum_view_model.dart';
import 'package:doc_connect/widgets/buttons.dart';
import 'package:doc_connect/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

class RespondInForum extends StatelessWidget {
  final String forumId;

  const RespondInForum({Key key, this.forumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RespondInForumViewModel>.reactive(
      viewModelBuilder: () => RespondInForumViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        backgroundColor: Colors.white,
        appBar: PlatformAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Respond',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: model.pop,
          ),
          material: (context, platform) => MaterialAppBarData(
            elevation: 4.0,
          ),
        ),
        body: _getBody(model),
      ),
    );
  }

  static final padding = EdgeInsets.only(top: 4.0, bottom: 4.0);

  Widget _getBody(RespondInForumViewModel model) {
    return Form(
      key: model.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          OutlinedTextField(
            label: 'Solution',
            hint: 'Briefly describe your solution',
            padding: padding,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            maxLines: 10,
            validateLength: 50,
            maxLength: 1200,
            save: (value) => model.response.answer = value,
          ),
          OutlinedTextField(
            label: 'Tips',
            hint: 'Any tips you would suggest(optional)',
            maxLines: 7,
            padding: padding,
            validateLength: 0,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            maxLength: 500,
            save: (value) => model.response.tips = value,
          ),
          SizedBox(height: 32.0),
          AppPlatformButton(
            text: 'SUBMIT',
            height: 50.0,
            width: double.infinity,
            borderRadius: 32.0,
            color: Colors.greenAccent,
            onPressed: () => model.validate(forumId),
          )
        ],
      ),
    );
  }
}
