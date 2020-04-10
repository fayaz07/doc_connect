class Chat {
  String id;

  // ignore: non_constant_identifier_names
  String requested_by;
  List<dynamic> users;

  // ignore: non_constant_identifier_names
  DateTime created_on;

  bool accepted, rejected;

  // ignore: non_constant_identifier_names
  Chat({
    this.id,
    this.users,
    // ignore: non_constant_identifier_names
    this.created_on,
    // ignore: non_constant_identifier_names
    this.requested_by,
    this.accepted,
    this.rejected,
  });

  factory Chat.fromJSON(var map) {
    return Chat(
      created_on: DateTime.parse(map['created_on']),
      id: map['_id'],
      users: map['users'],
      requested_by: map['requested_by'],
      accepted: map['accepted'],
      rejected: map['rejected'],
    );
  }

  static Map<String, dynamic> toJSON(Chat chat) {
    return {
      "created_on": chat.created_on,
      "users": chat.users,
      "_id": chat.id,
      "requested_by": chat.requested_by,
      "accepted": chat.accepted,
      "rejected": chat.rejected,
    };
  }

  @override
  String toString() {
    return 'Chat{id: $id, requested_by: $requested_by, users: $users, created_on: $created_on, accepted: $accepted, rejected: $rejected}';
  }
}

class InboxModel {
  Chat chat;

  // ignore: non_constant_identifier_names
  String lastMessage, photo_url, name;

  // ignore: non_constant_identifier_names
  InboxModel({this.chat, this.lastMessage, this.photo_url, this.name});
}

class Message {
  // ignore: non_constant_identifier_names
  String room_id, author_id, author, message;
  DateTime time;

  Message(
      // ignore: non_constant_identifier_names
      {this.room_id, this.author_id, this.author, this.message, this.time});

  factory Message.fromJSON(var map) {
    return Message(
        message: map['message'],
        author_id: map['author_id'],
        room_id: map['room_id'],
        author: map['author'],
        time: DateTime.parse(map['time']));
  }

  static Map<String, dynamic> toJSON(Message message) {
    return {
      "message": message.message,
      "room_id": message.room_id,
      "author": message.author,
      "author_id":message.author_id,
    };
  }


}
