import 'dart:convert';
import 'package:covid19doc/api/utils/logger.dart';
import 'package:covid19doc/api/utils/respone_handler.dart';
import 'package:covid19doc/api/utils/urls.dart';
import 'package:covid19doc/data_models/forum.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:covid19doc/data_models/user.dart';
import 'package:covid19doc/providers/session.dart';
import 'package:http/http.dart';

class DashboardAPI {
  static Future<Result> getDashboard() async {
    try {
      Response response =
          await get(Urls.dashboard, headers: Urls.getHeadersWithRefreshToken());
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        /// parsing auth data
        var decodedData = json.decode(response.body);
        Session.setAuthToken(response.headers[SharedPrefConstants.authToken]);
        Session.setRefreshToken(
            response.headers[SharedPrefConstants.refreshToken]);

        /// parsing user data as well as categories
        User user = User.fromJSON(decodedData['user']);
        var resultData = Map();

        resultData['user'] = user;

        List<User> nearby = [];

        if (user.is_doctor) {
          for (var c in decodedData['patients']) {
            nearby.add(User.fromJSON(c));
          }
          resultData['patients'] = nearby;
        } else {
          for (var c in decodedData['doctors']) {
            nearby.add(User.fromJSON(c));
          }
          resultData['doctors'] = nearby;
        }

        /// -- pulling forums
        List<Forum> forums = [];

        var jsonForums = decodedData['forums'];
        for (var c in jsonForums) {
          forums.add(Forum.fromJSON(c));
        }

        resultData['forums'] = forums;
        result.data = resultData;
      }
      return result;
    } catch (err) {
      Log.handleHttpCrash('Unable to get dashboard data', err);
      throw err;
    }
  }
}
