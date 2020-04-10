import 'dart:convert';
import 'package:covid19doc/api/utils/logger.dart';
import 'package:covid19doc/api/utils/respone_handler.dart';
import 'package:covid19doc/data_models/chat.dart';
import 'package:covid19doc/data_models/result.dart';
import 'package:http/http.dart';
import 'utils/urls.dart';

class ChatAPI {
  static Future<Result> createOrGetChatId(String user1, String user2) async {
    assert(user2 != null);
    assert(user1 != null);
    try {
      Response response = await post(
        Urls.getChatRoomId,
        body: jsonEncode({
          "users": [user1, user2],
        }),
        headers: Urls.getHeadersWithToken(),
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        result.data = Chat.fromJSON(json.decode(response.body)['chat']);
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to get chatroom id ", e);
      return Result(
          success: false,
          message: "Something has gone wrong, please try later");
    }
  }

  static Future<Result> getChats() async {
    try {
      Response response = await get(
        Urls.getChats,
        headers: Urls.getHeadersWithToken(),
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        var decoded = json.decode(response.body);
        String currentUser = decoded['user_id'];
//        List<Chat> chats = [];
        List<InboxModel> inboxEs = [];
        Map usernameAndAvatars = new Map();
        for (var c in decoded['avatars']) {
          usernameAndAvatars[c['user_id']] = {
            "name": c['first_name'] + " " + c['last_name'],
            "photo_url": c['photo_url']
          };
        }
        for (var c in decoded['chats']) {
          //chats.add(Chat.fromJSON(c));
          var chat = Chat.fromJSON(c);
          // find other persons uid
          var endUserId;
          for (var user in chat.users) {
            if (user.toString().contains(currentUser.toString().trim())) {
            } else {
              endUserId = user;
            }
          }
          inboxEs.add(
            InboxModel(
              chat: chat,
              name: usernameAndAvatars[endUserId]['name'],
              photo_url: usernameAndAvatars[endUserId]['photo_url'],
            ),
          );
        }
        result.data = inboxEs;
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to get chatroom id ", e);
      return Result(
          success: false,
          message: "Something has gone wrong, please try later");
    }
  }

  static Future<Result> acceptChatRequest(String chatId) async {
    try {
      Response response = await patch(
        Urls.acceptChatRequest,
        body: jsonEncode({"chat_id": chatId}),
        headers: Urls.getHeadersWithToken(),
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        result.data = Chat.fromJSON(json.decode(response.body)['chat']);
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to accpet/reject chat ", e);
      return Result(
          success: false,
          message: "Something has gone wrong, please try later");
    }
  }

  static Future<Result> rejectChatRequest(String chatId) async {
    try {
      Response response = await patch(
        Urls.rejectChatRequest,
        body: jsonEncode({"chat_id": chatId}),
        headers: Urls.getHeadersWithToken(),
      );

      Result result = ResponseHandler.getResult(response);
      if (result.success) {
        result.data = Chat.fromJSON(json.decode(response.body)['chat']);
      }
      return result;
    } on Exception catch (e) {
      Log.handleHttpCrash("Unable to accpet/reject chat ", e);
      return Result(
          success: false,
          message: "Something has gone wrong, please try later");
    }
  }
}
