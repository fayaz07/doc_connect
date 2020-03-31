class Forum {
  String key;

  // ignore: non_constant_identifier_names
  DateTime created_on;
  String author;
  String title;
  String description;

  List<Message> messages;

  // ignore: non_constant_identifier_names
  Forum(
      {this.key,
      // ignore: non_constant_identifier_names
      this.created_on,
      this.author,
      this.title,
      this.description,
      this.messages});

  factory Forum.fromJSON(var map) {
    return Forum(
      author: map['author'],
      key: map['key'],
      title: map['title'],
      description: map['description'],
      created_on: DateTime.parse(map['created_on']),
      messages:
          map['messages'] != null ? Message.fromJSONList(map['messages']) : [],
    );
  }

  static Map<String, dynamic> toJSON(Forum forum) {
    return {
      "author": forum.author,
      "title": forum.title,
      "description": forum.description,
    };
  }

  @override
  String toString() {
    return 'Forum{key: $key, created_on: $created_on, author: $author, title: $title, description: $description}';
  }
}

class Message {
  // ignore: non_constant_identifier_names
  String id, room_id;

  // ignore: non_constant_identifier_names
  String author, author_id, message;
  DateTime time;

  Message(
      {this.author,
      // ignore: non_constant_identifier_names
      this.author_id,
      this.message,
      this.time,
      this.id,
      // ignore: non_constant_identifier_names
      this.room_id});

  factory Message.fromJSON(var map) {
    return Message(
      id: map['_id'],
      room_id: map['room_id'],
      author_id: map['author_id'],
      author: map['author'],
      message: map['message'],
      time: DateTime.parse(map['time']),
    );
  }

  static Map<String, dynamic> toJSON(Message message) {
    return {
      "room_id": message.room_id,
      "author_id": message.author_id,
      "author": message.author,
      "message": message.message,
    };
  }

  static List<Message> fromJSONList(var list) {
    List<Message> messages = [];

    for (var c in list) {
      messages.add(Message.fromJSON(c));
    }

    return messages;
  }

  @override
  String toString() {
    return 'Message{room_id: $room_id, author: $author, message: $message}';
  }
}
