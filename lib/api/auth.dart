import 'dart:convert';
import 'package:doc_connect/data_models/auth.dart';
import 'package:doc_connect/data_models/forum.dart';
import 'package:doc_connect/data_models/result.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/providers/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'utils/logger.dart';
import 'utils/respone_handler.dart';
import 'utils/urls.dart';

class AuthAPI {
  /// For authentication of user
  /// For registering a user with email and password
  static Future<Result> register(
      {@required String email,
      @required String password,
      @required bool doctor}) async {
    assert(email != null);
    assert(password != null);
    try {
      Response response = await post(
        Urls.register,
        body: jsonEncode(
            {"email": email, "password": password, "is_doctor": doctor}),
        headers: Urls.defHeaders,
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to register", e);
      throw e;
    }
  }

  /// for logging in a user with email and password
  static Future<Result> login({String email, String password}) async {
    assert(email != null);
    assert(password != null);
    try {
      Response response = await post(
        Urls.login,
        body: jsonEncode({"email": email, "password": password}),
        headers: Urls.defHeaders,
      );
      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        var m = Map();
        m['auth'] = Auth(
            email: email,
            loggedIn: true,
            authToken: response.headers[SharedPrefConstants.authToken],
            refreshToken: response.headers[SharedPrefConstants.refreshToken],
            isDoctor: json.decode(response.body)['is_doctor'] ?? false);

        if (json.decode(response.body)['user'] == null) {
          m['user'] = null;
        } else {
          m['user'] = User.fromJSON(json.decode(response.body)['user']);
        }

        /// -- pulling forums
        List<ForumQuestion> forums = [];

        var jsonForums = json.decode(response.body)['forums'];
        for (var c in jsonForums) {
          forums.add(ForumQuestion.fromJSON(c));
        }

        m['forums'] = forums;

        List<User> nearby = [];

        if (json.decode(response.body)['is_doctor']) {
          for (var c in json.decode(response.body)['patients']) {
            nearby.add(User.fromJSON(c));
          }
          m['patients'] = nearby;
        } else {
          for (var c in json.decode(response.body)['doctors']) {
            nearby.add(User.fromJSON(c));
          }
          m['doctors'] = nearby;
        }

        result.data = m;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to login", e);
      throw e;
    }
  }

  /// for resending verification token, if the user has not recieved the email before or the old one has expired
  static Future<Result> resendVerificationToken(
      {String email, String password}) async {
    assert(email != null);
    assert(password != null);

    try {
      Response response = await post(
        Urls.resendVerificationToken,
        body: jsonEncode({"email": email, "password": password}),
        headers: Urls.defHeaders,
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to resendVerificationToken", e);
      throw e;
    }
  }

  /// if you are calling this method onSuccess-> you will get only
  /// refresh_token and access_token but not the email and password in the Auth object
  ///
  static Future<Result> authToken(String refreshToken) async {
    assert(refreshToken != null);
    try {
      Response response = await post(
        Urls.token,
        headers: {
          "Content-Type": "application/json",
          SharedPrefConstants.refreshToken: refreshToken
        },
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to get authToken", e);
      throw e;
    }
  }

  ///
  /// when the user has forgotten password, use this to send an OTP to the user
  static Future<Result> forgotPassword(String email) async {
    assert(email != null);
    try {
      Response response = await post(
        Urls.forgotPassword,
        body: jsonEncode({"email": email}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to send password reset code ", e);
      throw e;
    }
  }

  /// send the email, new password and
  static Future<Result> resetPassword(
      {String email, String newPassword, String otp}) async {
    assert(email != null);
    assert(newPassword != null);
    assert(otp != null);

    try {
      Response response = await post(
        Urls.resetPassword,
        body: jsonEncode({"email": email, "otp": otp, "password": newPassword}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to send password reset code ", e);
      throw e;
    }
  }

  /// send the email, new password and
  static Future<Result> changePassword(
      {String email, String oldPassword, String newPassword}) async {
    assert(email != null);
    assert(newPassword != null);
    assert(oldPassword != null);
    try {
      Response response = await patch(
        Urls.changePassword,
        body: jsonEncode({
          "email": email,
          "oldpassword": oldPassword,
          "newpassword": newPassword
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      return ResponseHandler.getResult(response);
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to send password reset code ", e);
      throw e;
    }
  }

  static Future<Result> fbAuthentication(
      String accessToken, bool doctor) async {
    try {
      Response response = await post(
        Urls.fbAuth,
        body: jsonEncode(
            {"access_token": accessToken, "doctor": doctor ?? false}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        final decoded = json.decode(response.body);
        print(decoded);
        var map = Map();
        map['user'] = User.fromJSON(decoded['user']);
        map['auth'] = Auth(
          email: (map['user'] as User).email,
          loggedIn: true,
          authToken: response.headers[SharedPrefConstants.authToken],
          refreshToken: response.headers[SharedPrefConstants.refreshToken],
          isDoctor: json.decode(response.body)['is_doctor'] ?? false,
        );

        // bool field
        map['signup'] = decoded['signup'];

        /// -- pulling forums
        List<ForumQuestion> forums = [];

        var jsonForums = decoded['forums'];
        for (var c in jsonForums) {
          forums.add(ForumQuestion.fromJSON(c));
        }

        map['forums'] = forums;

        // pulling doctors and patients
        List<User> nearby = [];

        for (var c in json.decode(response.body)['patients']) {
          nearby.add(User.fromJSON(c));
        }
        map['patients'] = nearby;
        nearby.clear();
        for (var c in json.decode(response.body)['doctors']) {
          nearby.add(User.fromJSON(c));
        }
        map['doctors'] = nearby;

        result.data = map;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to authenticate using facebook ", e);
      throw e;
    }
  }

  static Future<Result> googleAuthentication(
      String accessToken, bool doctor) async {
    try {
      Response response = await post(
        Urls.googleAuth,
        body: jsonEncode(
            {"access_token": accessToken, "doctor": doctor ?? false}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        final decoded = json.decode(response.body);
        print(decoded);
        var map = Map();
        map['user'] = User.fromJSON(decoded['user']);
        map['auth'] = Auth(
          email: (map['user'] as User).email,
          loggedIn: true,
          authToken: response.headers[SharedPrefConstants.authToken],
          refreshToken: response.headers[SharedPrefConstants.refreshToken],
          isDoctor: json.decode(response.body)['is_doctor'] ?? false,
        );

        // bool field
        map['signup'] = decoded['signup'];

        /// -- pulling forums
        List<ForumQuestion> forums = [];

        var jsonForums = decoded['forums'];
        for (var c in jsonForums) {
          forums.add(ForumQuestion.fromJSON(c));
        }

        map['forums'] = forums;

        // pulling doctors and patients
        List<User> nearby = [];

        for (var c in json.decode(response.body)['patients']) {
          nearby.add(User.fromJSON(c));
        }
        map['patients'] = nearby;
        nearby.clear();
        for (var c in json.decode(response.body)['doctors']) {
          nearby.add(User.fromJSON(c));
        }
        map['doctors'] = nearby;

        result.data = map;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to authenticate using facebook ", e);
      throw e;
    }
  }
}
