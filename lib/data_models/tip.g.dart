// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipAdapter extends TypeAdapter<Tip> {
  @override
  final int typeId = 9;

  @override
  Tip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tip(
      tip: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Tip obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.tip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
