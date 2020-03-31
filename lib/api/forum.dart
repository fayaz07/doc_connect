import 'dart:convert';

import 'package:covid19doc/data_models/forum.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:http/http.dart';

import 'utils/logger.dart';
import 'utils/respone_handler.dart';
import 'utils/urls.dart';

class ForumAPI {
  static Future<Result> createForum(Forum forum) async {
    try {
      Response response = await post(
        Urls.createForum,
        body: jsonEncode(Forum.toJSON(forum)),
        headers: Urls.getHeadersWithToken(),
      );

      Result result = ResponseHandler.getResult(response);

      if (result.success) {
        /// pull forum
        var forum = json.decode(response.body)['forum'];
        Forum newForum = Forum.fromJSON(forum);
        result.data = newForum;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to create new forum", e);
      throw e;
    }
  }
}
