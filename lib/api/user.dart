import 'dart:convert';
import 'package:covid19doc/api/utils/urls.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/data_models/user.dart';
import 'package:http/http.dart';
import 'utils/logger.dart';
import 'utils/respone_handler.dart';

class UserAPI {
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

  static Future<Result> getNearbyDoctors() async {
    try {
      Response response = await get(
        Urls.getNearbyDoctors,
        headers: Urls.getHeadersWithToken(),
      );
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        List<User> doctors = [];
        for (var c in json.decode(response.body)['doctors']) {}
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to saveUserDataForFirstTime", e);
      throw e;
    }
  }

  static Future<Result> searchDoctors(String query) async {
    try {
      Response response = await post(
        Urls.searchDoctors,
        body: jsonEncode({"query": query}),
        headers: Urls.getHeadersWithToken(),
      );
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        List<User> doctors = [];
        for (var c in json.decode(response.body)['doctors']) {
          doctors.add(User.fromJSON(c));
        }
        result.data = doctors;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to saveUserDataForFirstTime", e);
      throw e;
    }
  }
}
