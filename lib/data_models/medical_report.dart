import 'package:hive/hive.dart';

part 'medical_report.g.dart';

@HiveType(typeId: 8)
class MedicalReport {
  @HiveField(1)
  String id;

  @HiveField(2)
  String userId;

  //  R at the end - Remarks
  @HiveField(3)
  BloodGroup bloodGroup;

  // Vision
  @HiveField(4)
  bool visionDefect;

  @HiveField(5)
  bool spectacles;

  @HiveField(6)
  String visionR;

  // primary colors
  // cs-canSee
  @HiveField(7)
  bool csRed;

  @HiveField(8)
  bool csBlue;

  @HiveField(9)
  bool csGreen;

  @HiveField(10)
  bool cs24;

  @HiveField(11)
  bool cs20;

  @HiveField(12)
  bool cs16;

  @HiveField(13)
  bool cs12;

  @HiveField(14)
  bool cs8;

  @HiveField(15)
  String colorsR;

  // Hearing
  @HiveField(16)
  bool hearingIssues;

  @HiveField(17)
  bool hearingAids;

  @HiveField(18)
  String hearingR;

  // Physical deformity

  @HiveField(19)
  bool physicalDisability;

  @HiveField(20)
  bool mechanicalAssistance;

  @HiveField(21)
  String physicalDeformityRemarks;

  // By birth disease
  @HiveField(22)
  bool congenitalDisorder;

  @HiveField(23)
  String congenitalDisorderRemarks;

  // Psychiatric issues
  @HiveField(24)
  bool psychiatricIssues;

  @HiveField(25)
  String psychiatricRemarks;

  // illness or operation
  @HiveField(26)
  bool hadSurgeries;

  @HiveField(27)
  String operationRemarks;

  // alcohol
  @HiveField(28)
  bool alcohol;

  @HiveField(29)
  String alcoholRemarks;

  // smoke
  @HiveField(30)
  bool smoke;

  @HiveField(31)
  String smokeRemarks;

  // sugar
  @HiveField(32)
  bool sugar;

  @HiveField(33)
  int yearsSugar;

  @HiveField(34)
  String sugarRemarks;

  // BP
  @HiveField(35)
  bool bp;

  @HiveField(36)
  String bpRemarks;

  // Cancer
  @HiveField(37)
  bool cancer;

  @HiveField(38)
  String cancerRemarks;

  // Heart
  @HiveField(39)
  bool heartDiseases;

  @HiveField(40)
  String heartRemarks;

  // Tumour
  @HiveField(41)
  bool tumour;

  @HiveField(42)
  String tumourRemarks;

  // in ms
  @HiveField(43)
  double height;

  // in kgs
  @HiveField(44)
  double weight;

  // weight(kg)/[height(in meters)]*[height(in meters)]
  @HiveField(45)
  double bmi;

  @HiveField(46)
  String otherIllness;

  MedicalReport({this.id,
    this.userId,
    this.bloodGroup,
    this.visionR,
    this.csRed = false,
    this.csBlue = false,
    this.csGreen = false,
    this.cs24 = false,
    this.cs20 = false,
    this.cs16 = false,
    this.cs12 = false,
    this.cs8 = false,
    this.colorsR,
    this.hearingIssues = false,
    this.hearingAids = false,
    this.hearingR,
    this.physicalDisability = false,
    this.mechanicalAssistance = false,
    this.physicalDeformityRemarks,
    this.congenitalDisorder = false,
    this.congenitalDisorderRemarks,
    this.psychiatricIssues = false,
    this.psychiatricRemarks,
    this.hadSurgeries = false,
    this.operationRemarks,
    this.sugar = false,
      this.yearsSugar,
      this.sugarRemarks,
      this.bp = false,
      this.bpRemarks,
      this.cancer = false,
      this.cancerRemarks,
      this.tumour = false,
      this.tumourRemarks,
      this.alcohol = false,
      this.alcoholRemarks,
      this.smoke = false,
      this.smokeRemarks,
      this.heartDiseases = false,
      this.heartRemarks,
      this.height,
      this.weight,
      this.bmi,
      this.otherIllness,
      this.spectacles = false,
      this.visionDefect = false});

  static MedicalReport fromJSON(var map) {
    return MedicalReport(
      id: map["_id"],
      userId: map["user_id"],
      bloodGroup: bloodGroupFromString(map["blood_group"]),
      visionDefect: map["vision_defect"],
      spectacles: map["spectacles"],
      visionR: map["vision_r"],
      csRed: map["cs_red"],
      csBlue: map["cs_blue"],
      csGreen: map["cs_green"],
      cs24: map["cs24"],
      cs20: map["cs20"],
      cs16: map["cs16"],
      cs12: map["cs12"],
      cs8: map["cs8"],
      colorsR: map["colors_r"],
      hearingIssues: map["hearing_issues"],
      hearingAids: map["hearing_aids"],
      hearingR: map["hearing_r"],
      physicalDisability: map["physical_disability"],
      mechanicalAssistance: map["mechanical_assistance"],
      physicalDeformityRemarks: map["physical_deformity_r"],
      congenitalDisorder: map["congenital_disorder"],
      congenitalDisorderRemarks: map["congenital_disorder_r"],
      psychiatricIssues: map["psychiatric_issues"],
      psychiatricRemarks: map["psychiatric_r"],
      hadSurgeries: map["had_surgeries"],
      operationRemarks: map["operation_r"],
      alcohol: map["alcohol"],
      alcoholRemarks: map["alcohol_r"],
      smoke: map["smoke"],
      smokeRemarks: map["smoke_r"],
      sugar: map["sugar"],
      yearsSugar: map["years_sugar"],
      sugarRemarks: map["sugar_r"],
      bp: map["bp"],
      bpRemarks: map["bp_r"],
      cancer: map["cancer"],
      cancerRemarks: map["cancer_r"],
      heartDiseases: map["heart_diseases"],
      heartRemarks: map["heart_r"],
      tumour: map["tumour"],
      tumourRemarks: map["tumour_r"],
      height: double.parse(map["height"].toString()),
      weight: double.parse(map["weight"].toString()),
      bmi: double.parse(map["bmi"].toString()),
      otherIllness: map["other_illness"],
    );
  }

  static Map<String, dynamic> toJSON(MedicalReport mr) {
    return {
      "user_id": mr.userId,
      "blood_group": mr.bloodGroup.buttonText(),
      "vision_defect": mr.visionDefect,
      "spectacles": mr.spectacles,
      "vision_r": mr.visionR,
      "cs_red": mr.csRed,
      "cs_blue": mr.csBlue,
      "cs_green": mr.csGreen,
      "cs24": mr.cs24,
      "cs20": mr.cs20,
      "cs16": mr.cs16,
      "cs12": mr.cs12,
      "cs8": mr.cs8,
      "colors_r": mr.colorsR,
      "hearing_issues": mr.hearingIssues,
      "hearing_aids": mr.hearingAids,
      "hearing_r": mr.hearingR,
      "physical_disability": mr.physicalDisability,
      "mechanical_assistance": mr.mechanicalAssistance,
      "physical_deformity_r": mr.physicalDeformityRemarks,
      "congenital_disorder": mr.congenitalDisorder,
      "congenital_disorder_r": mr.congenitalDisorderRemarks,
      "psychiatric_issues": mr.psychiatricIssues,
      "psychiatric_r": mr.psychiatricRemarks,
      "had_surgeries": mr.hadSurgeries,
      "operation_r": mr.operationRemarks,
      "alcohol": mr.alcohol,
      "alcohol_r": mr.alcoholRemarks,
      "smoke": mr.smoke,
      "smoke_r": mr.smokeRemarks,
      "sugar": mr.sugar,
      "years_sugar": mr.yearsSugar,
      "sugar_r": mr.sugarRemarks,
      "bp": mr.bp,
      "bp_r": mr.bpRemarks,
      "cancer": mr.cancer,
      "cancer_r": mr.cancerRemarks,
      "heart_diseases": mr.heartDiseases,
      "heart_r": mr.heartRemarks,
      "tumour": mr.tumour,
      "tumour_r": mr.tumourRemarks,
      "height": mr.height,
      "weight": mr.weight,
      "bmi": mr.bmi,
      "other_illness": mr.otherIllness,
    };
  }

  @override
  String toString() {
    return 'MedicalReport{userId: $userId, bloodGroup: $bloodGroup, visionDefect: $visionDefect, spectacles: $spectacles, visionR: $visionR, csRed: $csRed, csBlue: $csBlue, csGreen: $csGreen, cs24: $cs24, cs20: $cs20, cs16: $cs16, cs12: $cs12, cs8: $cs8, colorsR: $colorsR, hearingIssues: $hearingIssues, hearingAids: $hearingAids, hearingR: $hearingR, physicalDisability: $physicalDisability, mechanicalAssistance: $mechanicalAssistance, physicalDeformityRemarks: $physicalDeformityRemarks, congenitalDisorder: $congenitalDisorder, congenitalDisorderRemarks: $congenitalDisorderRemarks, psychiatricIssues: $psychiatricIssues, psychiatricRemarks: $psychiatricRemarks, hadSurgeries: $hadSurgeries, operationRemarks: $operationRemarks, alcohol: $alcohol, alcoholRemarks: $alcoholRemarks, smoke: $smoke, smokeRemarks: $smokeRemarks, sugar: $sugar, yearsSugar: $yearsSugar, sugarRemarks: $sugarRemarks, bp: $bp, bpRemarks: $bpRemarks, cancer: $cancer, cancerRemarks: $cancerRemarks, heartDiseases: $heartDiseases, heartRemarks: $heartRemarks, tumour: $tumour, tumourRemarks: $tumourRemarks, height: $height, weight: $weight, bmi: $bmi, otherIllness: $otherIllness}';
  }
}

enum BloodGroup {
  A_Positive,
  B_Positive,
  AB_Positive,
  O_Positive,
  A_Negative,
  B_Negative,
  AB_Negative,
  O_Negative
}

BloodGroup bloodGroupFromString(String string) {
  if (string.contains("A") && !string.contains("AB")) {
    if (string.contains("+ve")) {
      return BloodGroup.A_Positive;
    }
    return BloodGroup.A_Negative;
  }
  if (string.contains("B") && !string.contains("AB")) {
    if (string.contains("+ve")) {
      return BloodGroup.B_Positive;
    }
    return BloodGroup.B_Negative;
  }
  if (string.contains("O")) {
    if (string.contains("+ve")) {
      return BloodGroup.O_Positive;
    }
    return BloodGroup.O_Negative;
  }
  if (string.contains("AB")) {
    if (string.contains("+ve")) {
      return BloodGroup.AB_Positive;
    }
    return BloodGroup.AB_Negative;
  }
  return null;
}

extension BGExtension on BloodGroup {
  String buttonText() {
    return this
        .toString()
        .replaceAll("BloodGroup.", "")
        .replaceAll("_", " ")
        .replaceAll("Positive", "+ve")
        .replaceAll("Negative", "-ve");
  }
}
