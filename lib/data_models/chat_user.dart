import 'package:hive/hive.dart';

part 'chat_user.g.dart';

@HiveType(typeId: 2, adapterName: 'ChatUserAdapter')
class ChatUser {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String photoUrl;

  @HiveField(3)
  String userId;

  ChatUser({this.firstName, this.lastName, this.photoUrl, this.userId});

  static ChatUser fromJSON(var map) {
    return ChatUser(
      userId: map['user_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      photoUrl: map['photo_url'],
    );
  }

  static List<ChatUser> fromJSONList(var list, String currUserId) {
    List<ChatUser> _kList = [];
    for (var c in list) {
      final chUser = ChatUser.fromJSON(c);
      if (!chUser.userId.contains(currUserId)) _kList.add(chUser);
    }
    return _kList;
  }
}
