// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForumQuestionAdapter extends TypeAdapter<ForumQuestion> {
  @override
  final int typeId = 5;

  @override
  ForumQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForumQuestion(
      id: fields[1] as String,
      authorId: fields[2] as String,
      topic: fields[3] as String,
      title: fields[4] as String,
      question: fields[5] as String,
      views: (fields[6] as List)?.cast<dynamic>(),
      createdAt: fields[7] as DateTime,
      solved: fields[8] as bool,
      solutionId: fields[9] as String,
      upVotes: (fields[10] as List)?.cast<dynamic>(),
      downVotes: (fields[11] as List)?.cast<dynamic>(),
      messages: (fields[12] as List)?.cast<ForumMessage>(),
      author: fields[13] as Author,
      noOfViews: fields[14] as int,
      noOfUpVotes: fields[15] as int,
      noOfDownVotes: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ForumQuestion obj) {
    writer
      ..writeByte(16)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.authorId)
      ..writeByte(3)
      ..write(obj.topic)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.question)
      ..writeByte(6)
      ..write(obj.views)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.solved)
      ..writeByte(9)
      ..write(obj.solutionId)
      ..writeByte(10)
      ..write(obj.upVotes)
      ..writeByte(11)
      ..write(obj.downVotes)
      ..writeByte(12)
      ..write(obj.messages)
      ..writeByte(13)
      ..write(obj.author)
      ..writeByte(14)
      ..write(obj.noOfViews)
      ..writeByte(15)
      ..write(obj.noOfUpVotes)
      ..writeByte(16)
      ..write(obj.noOfDownVotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ForumMessageAdapter extends TypeAdapter<ForumMessage> {
  @override
  final int typeId = 6;

  @override
  ForumMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForumMessage();
  }

  @override
  void write(BinaryWriter writer, ForumMessage obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
