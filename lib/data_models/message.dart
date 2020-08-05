import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 35, adapterName: 'MessageAdapter')
class Message {
  @HiveField(0)
  String id;

  @HiveField(1)
  String roomId;

  @HiveField(2)
  String authorId;

  @HiveField(3)
  String message;

  @HiveField(4)
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
