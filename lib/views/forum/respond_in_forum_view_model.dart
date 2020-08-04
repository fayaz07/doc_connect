import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class RespondInForumViewModel extends ChangeNotifier {
  BuildContext _context;

  final formKey = GlobalKey<FormState>();

  ForumMessage _response = ForumMessage();

  init(BuildContext context) {
    _context = context;
  }

  Future<void> validate(String forumId) async {
    if (!formKey.currentState.validate()) {
      AppToast.show(text: "Please fill in valid details");
      return;
    }
    showLoader(isModal: true);
    formKey.currentState.save();

    _response.forumId = forumId;

    final user = Provider.of<UsersService>(_context, listen: false).user;

    _response.author = Author(
      isDoctor: user.isDoctor,
      age: user.age,
      gender: user.gender,
      profession: user.profession,
      speciality: user.speciality,
      lastName: user.lastName,
      firstName: user.firstName,
    );

    final bool success =
        await Provider.of<ForumsService>(_context, listen: false)
            .addResponse(_response);
    hideLoader();
    if (success) {
      pop();
    }
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  ForumMessage get response => _response;

  set response(ForumMessage value) {
    _response = value;
    notifyListeners();
  }
}
