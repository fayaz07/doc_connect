// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthorAdapter extends TypeAdapter<Author> {
  @override
  final int typeId = 7;

  @override
  Author read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Author(
      gender: fields[0] as String,
      firstName: fields[5] as String,
      lastName: fields[6] as String,
      speciality: fields[1] as String,
      profession: fields[2] as String,
      age: fields[3] as int,
      isDoctor: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Author obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.speciality)
      ..writeByte(2)
      ..write(obj.profession)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.isDoctor)
      ..writeByte(5)
      ..write(obj.firstName)
      ..writeByte(6)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
