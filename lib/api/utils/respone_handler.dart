import 'dart:convert';

import 'package:covid19doc/data_models/result.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ResponseHandler {
  static Result getResult(Response response) {
    /// 200 - success
    /// 201 - created
    /// 400 - bad request
    /// 401 - unauthorized
    /// 403 - Forbidden
    /// 404 - Not Found
    /// 409 - Conflict
    /// 500 - Internal Server Error
    debugPrint('----------------Response---------------');
    debugPrint(response.body);
    debugPrint('---------------------------------------');

    final message = json.decode(response.body)['message'];
    switch (response.statusCode) {
      case 200:
        return Result(
          success: true,
          message: message ?? 'Success',
        );
      case 201:
        return Result(
          success: true,
          message: message ?? 'Created',
        );
      case 400:
        return Result(
          success: false,
          message: message ?? 'Bad request',
        );
      case 401:
        return Result(
          success: false,
          message: message ?? 'Unauthorized',
        );
      case 403:
        return Result(
          success: false,
          message: message ?? 'Forbidden',
        );
      case 404:
        return Result(
          success: false,
          message: message ?? 'Not Found',
        );
      case 409:
        return Result(
          success: false,
          message: message ?? 'Conflict',
        );
      case 500:
        return Result(
          success: false,
          message: message ?? 'Internal Server Error',
        );
      default:
        return Result(
          success: false,
          message: 'Something has gone wrong',
        );
    }
  }
}
