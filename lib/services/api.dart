import 'dart:convert';
import 'package:chopper/chopper.dart' show Request, Response;
import 'package:doc_connect/api/api.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/services/forums.dart';
import 'package:doc_connect/services/tip.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class APIService {
  static final DocConnectAPI api = DocConnectAPI.create();

  static Request currentRequest;

  Future<void> getDashboard(BuildContext context) async {
    try {
      final lastTimestamp = await AuthService.getTimestamp();
      print(lastTimestamp ?? "null bro");
      final Response response = await APIService.api
          .getDashboard(lastTimestamp?.toIso8601String() ?? "");
      if (response.isSuccessful) {
        //AuthService.parseAndStoreHeaders(response);
        final decodedJson = json.decode(response.body);
        Provider.of<UsersService>(context, listen: false)
            .parseUserDocPatients(decodedJson);
        Provider.of<ForumsService>(context, listen: false)
            .parseForumQuestions(decodedJson);
        Provider.of<TipService>(context, listen: false).parseTips(decodedJson);
        AuthService.storeTimestamp(
            DateTime.now().subtract(Duration(seconds: 20)));
//      LocalDB()..init();
        return;
      } else {
        debugPrint(response.body);
        AppToast.showError(response);
      }
    } catch (err) {
      print(err);
      throw err;
    }
    return;
  }
}
