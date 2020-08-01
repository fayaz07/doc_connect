import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:doc_connect/data_models/user.dart';
import 'package:doc_connect/services/api.dart';
import 'package:doc_connect/services/chat.dart';
import 'package:doc_connect/services/users.dart';
import 'package:doc_connect/utils/navigation.dart';
import 'package:doc_connect/utils/toast.dart';
import 'package:doc_connect/views/appointment/new_appointment.dart';
import 'package:doc_connect/views/appointment/new_appointment_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

class GuestProfileViewModel extends ChangeNotifier {
  BuildContext _context;
  User user = User();

  void init(BuildContext context, User guestUser) {
    _context = context;
    user = guestUser;
  }

  void pop() {
    Navigator.of(_context).pop();
  }

  void handleCall() {
    if (user.availableForCall) {
      print('lets call');
    } else {
      print('not available');
    }
  }

  Future<void> handleChat() async {
    showLoader();
    final Response response =
        await APIService.api.createORGetChatRoomId(jsonEncode({
      "users": [
        Provider.of<UsersProvider>(_context, listen: false).user.id,
        user.id
      ]
    }));
    if (response.isSuccessful) {
      // got the chat model here
      final chat = json.decode(response.body)["chat"];
      Provider.of<ChatService>(_context, listen: false).addChat(chat);
    }
  }

  Future<void> offerOrApplyForAppointment(User guestUser) async {
    Navigator.of(_context).push(
      AppNavigation.route(
        NewAppointmentScreen(
          guestUser: guestUser,
        ),
      ),
    );
//    showLoader(isModal: true);
//    final body =
//        jsonEncode(isRequest ? {"doctorId": userId} : {"patientId": userId});
//    final response = await APIService.api.offerOrApplyForAppointment(body);
//    hideLoader();
//    if (response.isSuccessful) {
//      AppToast.show(text: json.decode(response.body)["message"]);
//    } else {
//      AppToast.showError(response);
//    }
  }
}
