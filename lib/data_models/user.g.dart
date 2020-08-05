// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 10;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      email: fields[1] as String,
      isDoctor: fields[5] as bool,
      createdAt: fields[21] as DateTime,
      availability: fields[12] as String,
      availableForCall: fields[6] as bool,
      availableForChat: fields[7] as bool,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      website: fields[13] as String,
      profession: fields[14] as String,
      speciality: fields[19] as String,
      gender: fields[15] as String,
      location: fields[16] as String,
      latitude: fields[17] as double,
      longitude: fields[18] as double,
      age: fields[20] as int,
      popularity: fields[22] as double,
      knownLanguages: fields[4] as String,
      reviews: (fields[23] as List)?.cast<UserReview>(),
      hospitalName: fields[8] as String,
      workplace: fields[9] as String,
      photoUrl: fields[10] as String,
      symptoms: fields[11] as String,
      additionalData: (fields[25] as Map)?.cast<dynamic, dynamic>(),
      preMedicalReportId: fields[24] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.knownLanguages)
      ..writeByte(5)
      ..write(obj.isDoctor)
      ..writeByte(6)
      ..write(obj.availableForCall)
      ..writeByte(7)
      ..write(obj.availableForChat)
      ..writeByte(8)
      ..write(obj.hospitalName)
      ..writeByte(9)
      ..write(obj.workplace)
      ..writeByte(10)
      ..write(obj.photoUrl)
      ..writeByte(11)
      ..write(obj.symptoms)
      ..writeByte(12)
      ..write(obj.availability)
      ..writeByte(13)
      ..write(obj.website)
      ..writeByte(14)
      ..write(obj.profession)
      ..writeByte(15)
      ..write(obj.gender)
      ..writeByte(16)
      ..write(obj.location)
      ..writeByte(17)
      ..write(obj.latitude)
      ..writeByte(18)
      ..write(obj.longitude)
      ..writeByte(19)
      ..write(obj.speciality)
      ..writeByte(20)
      ..write(obj.age)
      ..writeByte(21)
      ..write(obj.createdAt)
      ..writeByte(22)
      ..write(obj.popularity)
      ..writeByte(23)
      ..write(obj.reviews)
      ..writeByte(24)
      ..write(obj.preMedicalReportId)
      ..writeByte(25)
      ..write(obj.additionalData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
