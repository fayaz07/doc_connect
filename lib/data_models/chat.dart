import 'package:doc_connect/data_models/chat_user.dart';
import 'package:hive/hive.dart';

part 'chat.g.dart';

@HiveType(typeId: 1, adapterName: 'ChatAdapter')
class Chat {
  @HiveField(0)
  String id;

  @HiveField(1)
  String requestedBy;

  @HiveField(2)
  bool requestedBySelf;

  @HiveField(3)
  List<ChatUser> users;

  @HiveField(4)
  DateTime createdOn;

  @HiveField(5)
  bool accepted;

  @HiveField(6)
  bool rejected;

  Chat({
    this.id,
    this.users,
    this.createdOn,
    this.requestedBy,
    this.accepted,
    this.rejected,
    this.requestedBySelf,
  });

  factory Chat.fromJSON(var map, String currUserId) {
    return Chat(
      createdOn: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      id: map['_id'],
      users: ChatUser.fromJSONList(map['users'], currUserId),
      requestedBy: map['requested_by'],
      accepted: map['accepted'],
      rejected: map['rejected'],
      requestedBySelf: map['requested_by'].toString().contains(currUserId),
    );
  }

  static Map<String, Chat> parseAsMap(var jsonList, String currUserId) {
    Map<String, Chat> _mappedChats = Map();
    for (var c in jsonList) {
      final chat = Chat.fromJSON(c, currUserId);
      _mappedChats[chat.id] = chat;
    }
    return _mappedChats;
  }

  static Map<String, dynamic> toJSON(Chat chat) {
    return {
      "created_on": chat.createdOn,
      "users": chat.users,
      "_id": chat.id,
      "requested_by": chat.requestedBy,
      "accepted": chat.accepted,
      "rejected": chat.rejected,
    };
  }

  @override
  String toString() {
    return 'Chat{id: $id, requested_by: $requestedBy, users: $users, created_on: $createdOn, accepted: $accepted, rejected: $rejected}';
  }
}
