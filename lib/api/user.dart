import 'dart:convert';
import 'package:covid19doc/api/utils/urls.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/data_models/user.dart';
import 'package:http/http.dart';
import 'utils/logger.dart';
import 'utils/respone_handler.dart';

class UserAPI {
  /// for logging in a user with email and password
  static Future<Result> saveUserDataForFirstTime(User user) async {
    try {
      Response response = await post(
        Urls.saveUserDataForFistTime,
        body: jsonEncode(User.toJSON(user)),
        headers: Urls.getHeadersWithToken(),
      );
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        result.data = User.fromJSON(json.decode(response.body)['user']);
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to saveUserDataForFirstTime", e);
      throw e;
    }
  }

  static Future<Result> updatePreferences({List preferences}) async {
    try {
      print(preferences);
      Response response = await patch(
        Urls.updateUserPreferences,
        body: jsonEncode({"preferences": preferences}),
        headers: Urls.getHeadersWithToken(),
      );
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        result.data = User.fromJSON(json.decode(response.body)['user']);
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to updatePreferences", e);
      throw e;
    }
  }
}
