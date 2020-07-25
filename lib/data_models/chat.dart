class Chat {
  String id;
  String requestedBy;
  bool requestedBySelf;
  List<ChatUser> users;
  DateTime createdOn;
  bool accepted, rejected;

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
//      createdOn: map['created_on'] != null
//          ? DateTime.parse(map['created_on'])
//          : DateTime.now(),
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

class ChatUser {
  String firstName, lastName, photoUrl, userId;

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

class Message {
  String id;
  String roomId, authorId, message;
  DateTime time;

  Message({this.id, this.roomId, this.authorId, this.message, this.time});

  factory Message.fromJSON(var map) {
    return Message(
      id: map["_id"],
      message: map['message'],
      authorId: map['author_id'],
      roomId: map['room_id'],
      time: DateTime.parse(map['time']),
    );
  }

  static Map<String, dynamic> toJSON(Message message) {
    return {
      "message": message.message,
      "room_id": message.roomId,
      "author_id": message.authorId,
    };
  }
}
