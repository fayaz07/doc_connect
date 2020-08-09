import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/api/urls.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

part 'api.chopper.dart';

final _kClient = http.Client();

Request lastRequest;

@ChopperApi()
abstract class DocConnectAPI extends ChopperService {
  /// auth apis
  @Post(path: Urls.register)
  Future<Response<dynamic>> register(@body dynamic body);

  @Post(path: Urls.login)
  Future<Response<dynamic>> login(@body dynamic body);

  @Post(path: Urls.token)
  Future<Response<dynamic>> refreshToken();

  @Post(path: Urls.fbAuth)
  Future<Response<dynamic>> fbAuth(@body dynamic body);

  @Post(path: Urls.googleAuth)
  Future<Response<dynamic>> googleAuth(@body dynamic body);

  @Patch(path: Urls.fcmId)
  Future<Response<dynamic>> updateFCMId(@body dynamic body);

  /// dashboard api
  @Get(path: Urls.dashboard + "/{timestamp}")
  Future<Response<dynamic>> getDashboard(@Path() String timestamp);

  /// user apis
  @Patch(path: Urls.user)
  Future<Response<dynamic>> updateUserDetails(@body dynamic body);

  @Get(path: Urls.user)
  Future<Response<dynamic>> getUserDetails();

  @Patch(path: Urls.user + "/type")
  Future<Response<dynamic>> updateUserType(@body dynamic body);

  /// Forum apis
  @Post(path: Urls.forum)
  Future<Response<dynamic>> askQuestionInForum(@body dynamic body);

  @Get(path: Urls.forum)
  Future<Response<dynamic>> getForums();

  @Get(path: Urls.forumResponse + "/{id}")
  Future<Response<dynamic>> getResponses(@Path() String id);

  @Post(path: Urls.forumResponse)
  Future<Response<dynamic>> respond(@body dynamic body);

  @Post(path: Urls.upVoteForumQuestion)
  Future<Response<dynamic>> upVoteForumQ(@body dynamic body);

  @Post(path: Urls.downVoteForumQuestion)
  Future<Response<dynamic>> downVoteForumQ(@body dynamic body);

  @Post(path: Urls.upVoteForumResponse)
  Future<Response<dynamic>> upVoteForumR(@body dynamic body);

  @Post(path: Urls.downVoteForumResponse)
  Future<Response<dynamic>> downVoteForumR(@body dynamic body);

  /// Chat
  @Get(path: Urls.getChats)
  Future<Response<dynamic>> getChats();

  @Post(path: Urls.getChatRoomId)
  Future<Response<dynamic>> createORGetChatRoomId(@body dynamic body);

  @Patch(path: Urls.acceptChatRequest)
  Future<Response<dynamic>> acceptChatRequest(@body dynamic body);

  @Patch(path: Urls.rejectChatRequest)
  Future<Response<dynamic>> rejectChatRequest(@body dynamic body);

  /// appointment
  @Post(path: Urls.appointment)
  Future<Response<dynamic>> offerOrApplyForAppointment(@body dynamic body);

  @Get(path: Urls.appointment)
  Future<Response<dynamic>> getAppointments();

  @Patch(path: Urls.appointment)
  Future<Response<dynamic>> updateAppointment(@body dynamic body);

  @Patch(path: Urls.appointment)
  Future<Response<dynamic>> cancelAppointment(@body dynamic body);

  @Patch(path: Urls.acceptAppointmentReqOff)
  Future<Response<dynamic>> acceptAppointmentReqOff(@body dynamic body);

  @Patch(path: Urls.rejectAppointmentReqOff)
  Future<Response<dynamic>> rejectAppointmentReqOff(@body dynamic body);

  /// notification
  @Get(path: Urls.notifications)
  Future<Response<dynamic>> getNotifications();

  /// medical report
  @Post(path: Urls.medicalReport)
  Future<Response<dynamic>> saveReport(@body dynamic body);

  @Get(path: Urls.medicalReport + "/{id}")
  Future<Response<dynamic>> getReport(@Path() String id);

  static DocConnectAPI create() {
    final client = ChopperClient(
      baseUrl: Urls.baseURL,
      services: [
        _$DocConnectAPI(),
      ],
      //converter: ModelConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        HeadersInterceptor(),
        TokenInterceptor(),
      ],
    );
    return _$DocConnectAPI(client);
  }
}

class HeadersInterceptor extends RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    var headers = {
      "Content-Type": "application/json",
    };

    if (AuthService.authData?.authToken != null &&
        AuthService.authData.authToken.length > 10) {
      headers.addAll({Constants.authToken: AuthService.authData.authToken});
    }

    if (!request.url.contains("/token")) {
      lastRequest = request.copyWith(headers: headers);
    }

    return request.copyWith(headers: headers);
  }
}

class TokenInterceptor extends ResponseInterceptor {
  Future<void> dudeRefreshMyToken() async {
    final response = await http.post(Urls.baseURL + Urls.token, headers: {
      "Content-Type": "application/json",
      Constants.authToken: AuthService.authData.authToken,
      Constants.refreshToken: AuthService.authData.refreshToken
    });
    if (response.statusCode == 200) {
      print(response.headers);
      await AuthService.storeTokens(response.headers[Constants.authToken],
          response.headers[Constants.refreshToken]);
    } else {
      debugPrint(
          "Failed to fetch token. I believed that works and didn't catch, I might catch this in future");
    }
  }

  @override
  FutureOr<Response> onResponse(Response response) async {
    if (response.statusCode == 401 && response.error != null) {
      final parsedError = json.decode(response.error);

      if (parsedError["message"] != null &&
          parsedError.toString().toLowerCase().contains("expired")) {
        debugPrint('token expired, refreshing the token and resending request');

        await dudeRefreshMyToken();

        lastRequest = lastRequest.copyWith(headers: {
          "Content-Type": "application/json",
          Constants.authToken: AuthService.authData.authToken
        });

        final request = await lastRequest.toBaseRequest();

        final stream = await _kClient.send(request);
        final res = await http.Response.fromStream(stream);

        return Response(res, res.body);
      }
    }
    return response;
  }
}
