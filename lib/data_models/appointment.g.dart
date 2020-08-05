// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentAdapter extends TypeAdapter<Appointment> {
  @override
  final int typeId = 4;

  @override
  Appointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appointment(
      id: fields[0] as String,
      patient: fields[1] as String,
      doctor: fields[2] as String,
      requestAccepted: fields[3] as bool,
      requestRejected: fields[4] as bool,
      offered: fields[5] as bool,
      offerAccepted: fields[6] as bool,
      offerRejected: fields[7] as bool,
      scheduledDate: fields[8] as DateTime,
      problemDescription: fields[9] as String,
      problem: fields[10] as String,
      preMedicalReport: fields[11] as String,
      endUser: fields[12] as ChatUser,
      cancelledByDoctor: fields[13] as bool,
      cancelledByPatient: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Appointment obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.patient)
      ..writeByte(2)
      ..write(obj.doctor)
      ..writeByte(3)
      ..write(obj.requestAccepted)
      ..writeByte(4)
      ..write(obj.requestRejected)
      ..writeByte(5)
      ..write(obj.offered)
      ..writeByte(6)
      ..write(obj.offerAccepted)
      ..writeByte(7)
      ..write(obj.offerRejected)
      ..writeByte(8)
      ..write(obj.scheduledDate)
      ..writeByte(9)
      ..write(obj.problemDescription)
      ..writeByte(10)
      ..write(obj.problem)
      ..writeByte(11)
      ..write(obj.preMedicalReport)
      ..writeByte(12)
      ..write(obj.endUser)
      ..writeByte(13)
      ..write(obj.cancelledByDoctor)
      ..writeByte(14)
      ..write(obj.cancelledByPatient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
