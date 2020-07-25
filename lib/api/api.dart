import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/api/urls.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/auth.dart';
import 'package:doc_connect/utils/constants.dart';
import 'package:flutter/cupertino.dart';

part 'api.chopper.dart';

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
  @Get(path: Urls.dashboard)
  Future<Response<dynamic>> getDashboard();

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
//        TokenInterceptor(),
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

    // todo: to be removed after, auth-token refreshing interceptor is added
    if (request.url.contains("dashboard") || request.url.contains("token")) {
      headers
          .addAll({Constants.refreshToken: AuthService.authData.refreshToken});
    } else {
      APIService.currentRequest = request;
    }
    return request.copyWith(headers: headers);
  }
}

bool retry = false;

class TokenInterceptor extends ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) async {
    if (response.statusCode == 401 && !retry) {
      final res = await response.base.request.send();

      print(res.statusCode);
      retry = true;
      final refreshResponse = await APIService.api.refreshToken();
      retry = false;
      if (refreshResponse.isSuccessful) {
        await AuthService.parseAndStoreHeaders(refreshResponse);
      } else {
        return refreshResponse;
      }
    }
    return response;
  }
}
