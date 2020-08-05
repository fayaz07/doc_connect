// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicalReportAdapter extends TypeAdapter<MedicalReport> {
  @override
  final int typeId = 8;

  @override
  MedicalReport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicalReport(
      id: fields[1] as String,
      userId: fields[2] as String,
      bloodGroup: fields[3] as BloodGroup,
      visionR: fields[6] as String,
      csRed: fields[7] as bool,
      csBlue: fields[8] as bool,
      csGreen: fields[9] as bool,
      cs24: fields[10] as bool,
      cs20: fields[11] as bool,
      cs16: fields[12] as bool,
      cs12: fields[13] as bool,
      cs8: fields[14] as bool,
      colorsR: fields[15] as String,
      hearingIssues: fields[16] as bool,
      hearingAids: fields[17] as bool,
      hearingR: fields[18] as String,
      physicalDisability: fields[19] as bool,
      mechanicalAssistance: fields[20] as bool,
      physicalDeformityRemarks: fields[21] as String,
      congenitalDisorder: fields[22] as bool,
      congenitalDisorderRemarks: fields[23] as String,
      psychiatricIssues: fields[24] as bool,
      psychiatricRemarks: fields[25] as String,
      hadSurgeries: fields[26] as bool,
      operationRemarks: fields[27] as String,
      sugar: fields[32] as bool,
      yearsSugar: fields[33] as int,
      sugarRemarks: fields[34] as String,
      bp: fields[35] as bool,
      bpRemarks: fields[36] as String,
      cancer: fields[37] as bool,
      cancerRemarks: fields[38] as String,
      tumour: fields[41] as bool,
      tumourRemarks: fields[42] as String,
      alcohol: fields[28] as bool,
      alcoholRemarks: fields[29] as String,
      smoke: fields[30] as bool,
      smokeRemarks: fields[31] as String,
      heartDiseases: fields[39] as bool,
      heartRemarks: fields[40] as String,
      height: fields[43] as double,
      weight: fields[44] as double,
      bmi: fields[45] as double,
      otherIllness: fields[46] as String,
      spectacles: fields[5] as bool,
      visionDefect: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicalReport obj) {
    writer
      ..writeByte(46)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.bloodGroup)
      ..writeByte(4)
      ..write(obj.visionDefect)
      ..writeByte(5)
      ..write(obj.spectacles)
      ..writeByte(6)
      ..write(obj.visionR)
      ..writeByte(7)
      ..write(obj.csRed)
      ..writeByte(8)
      ..write(obj.csBlue)
      ..writeByte(9)
      ..write(obj.csGreen)
      ..writeByte(10)
      ..write(obj.cs24)
      ..writeByte(11)
      ..write(obj.cs20)
      ..writeByte(12)
      ..write(obj.cs16)
      ..writeByte(13)
      ..write(obj.cs12)
      ..writeByte(14)
      ..write(obj.cs8)
      ..writeByte(15)
      ..write(obj.colorsR)
      ..writeByte(16)
      ..write(obj.hearingIssues)
      ..writeByte(17)
      ..write(obj.hearingAids)
      ..writeByte(18)
      ..write(obj.hearingR)
      ..writeByte(19)
      ..write(obj.physicalDisability)
      ..writeByte(20)
      ..write(obj.mechanicalAssistance)
      ..writeByte(21)
      ..write(obj.physicalDeformityRemarks)
      ..writeByte(22)
      ..write(obj.congenitalDisorder)
      ..writeByte(23)
      ..write(obj.congenitalDisorderRemarks)
      ..writeByte(24)
      ..write(obj.psychiatricIssues)
      ..writeByte(25)
      ..write(obj.psychiatricRemarks)
      ..writeByte(26)
      ..write(obj.hadSurgeries)
      ..writeByte(27)
      ..write(obj.operationRemarks)
      ..writeByte(28)
      ..write(obj.alcohol)
      ..writeByte(29)
      ..write(obj.alcoholRemarks)
      ..writeByte(30)
      ..write(obj.smoke)
      ..writeByte(31)
      ..write(obj.smokeRemarks)
      ..writeByte(32)
      ..write(obj.sugar)
      ..writeByte(33)
      ..write(obj.yearsSugar)
      ..writeByte(34)
      ..write(obj.sugarRemarks)
      ..writeByte(35)
      ..write(obj.bp)
      ..writeByte(36)
      ..write(obj.bpRemarks)
      ..writeByte(37)
      ..write(obj.cancer)
      ..writeByte(38)
      ..write(obj.cancerRemarks)
      ..writeByte(39)
      ..write(obj.heartDiseases)
      ..writeByte(40)
      ..write(obj.heartRemarks)
      ..writeByte(41)
      ..write(obj.tumour)
      ..writeByte(42)
      ..write(obj.tumourRemarks)
      ..writeByte(43)
      ..write(obj.height)
      ..writeByte(44)
      ..write(obj.weight)
      ..writeByte(45)
      ..write(obj.bmi)
      ..writeByte(46)
      ..write(obj.otherIllness);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicalReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
