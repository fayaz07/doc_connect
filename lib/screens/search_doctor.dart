import 'package:covid19doc/api/user.dart';
import 'package:covid19doc/data_models/user.dart';
import 'package:covid19doc/screens/base_view.dart';
import 'package:covid19doc/utils/widgets/app_bar.dart';
import 'package:covid19doc/utils/widgets/text_field.dart';
import 'package:covid19doc/utils/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchDoctor extends StatefulWidget {
  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  TextEditingController _controller = TextEditingController();

  List<User> users = [];
  bool searched = false;
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      showLoader: searching,
      child: Scaffold(
        appBar: MyAppbar(
          title: 'Search doctor',
          handleGoBack: () {
            Navigator.of(context).pop();
          },
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 4,
                    child: AppTextField(
                      controller: _controller,
                      hint: 'Ex: Heart specialist',
                      label: 'Search',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                        IconButton(icon: Icon(Icons.search), onPressed: search),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: searched && users != null && users.length == 0
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, i) => UserWidget(
                        user: users[i],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  search() async {
    if (_controller.text.length < 2) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      searching = true;
    });
    final results = await UserAPI.searchDoctors(_controller.text);
    if (results.success) {
      users = results.data;
    } else {
      // some error
    }
    setState(() {
      searching = false;
    });
  }
}
