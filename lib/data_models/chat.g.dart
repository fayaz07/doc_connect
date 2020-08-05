// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatAdapter extends TypeAdapter<Chat> {
  @override
  final int typeId = 1;

  @override
  Chat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chat(
      id: fields[0] as String,
      users: (fields[3] as List)?.cast<ChatUser>(),
      createdOn: fields[4] as DateTime,
      requestedBy: fields[1] as String,
      accepted: fields[5] as bool,
      rejected: fields[6] as bool,
      requestedBySelf: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Chat obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.requestedBy)
      ..writeByte(2)
      ..write(obj.requestedBySelf)
      ..writeByte(3)
      ..write(obj.users)
      ..writeByte(4)
      ..write(obj.createdOn)
      ..writeByte(5)
      ..write(obj.accepted)
      ..writeByte(6)
      ..write(obj.rejected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
