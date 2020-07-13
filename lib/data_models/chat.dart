class Chat {
  String id;
  String requestedBy;
  List<dynamic> users;
  DateTime createdOn;
  bool accepted, rejected;

  Chat({
    this.id,
    this.users,
    this.createdOn,
    this.requestedBy,
    this.accepted,
    this.rejected,
  });

  factory Chat.fromJSON(var map) {
    return Chat(
      createdOn: DateTime.parse(map['created_on']),
      id: map['_id'],
      users: map['users'],
      requestedBy: map['requested_by'],
      accepted: map['accepted'],
      rejected: map['rejected'],
    );
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

class InboxModel {
  Chat chat;

  String lastMessage, photoUrl, name;

  InboxModel({this.chat, this.lastMessage, this.photoUrl, this.name});
}

class Message {
  String roomId, authorId, author, message;
  DateTime time;

  Message(
      {this.roomId,
      this.authorId,
      this.author,
      this.message,
      this.time});

  factory Message.fromJSON(var map) {
    return Message(
        message: map['message'],
        authorId: map['author_id'],
        roomId: map['room_id'],
        author: map['author'],
        time: DateTime.parse(map['time']));
  }

  static Map<String, dynamic> toJSON(Message message) {
    return {
      "message": message.message,
      "room_id": message.roomId,
      "author": message.author,
      "author_id": message.authorId,
    };
  }
}
