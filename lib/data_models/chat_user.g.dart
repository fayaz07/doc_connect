// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatUserAdapter extends TypeAdapter<ChatUser> {
  @override
  final int typeId = 2;

  @override
  ChatUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatUser(
      firstName: fields[0] as String,
      lastName: fields[1] as String,
      photoUrl: fields[2] as String,
      userId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatUser obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
