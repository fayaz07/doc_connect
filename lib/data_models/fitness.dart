class Fitness {
  //  R at the end - Remarks
  BloodGroup bloodGroup;

  // Vision
  bool visionDefect;
  bool spectacles;
  String visionRemarks;

  // pigmentary colors
  // cs-canSee
  bool csRed;
  bool csBlue;
  bool csGreen;
  bool cs24;
  bool cs20;
  bool cs16;
  bool cs12;
  bool cs8;
  String visionR;

  // Hearing
  bool hearingIssues;
  bool hearingAids;
  String hearingR;

  // Physical deformity
  bool physicalDisability;
  bool mechanicalAssistance;
  String physicalDeformityRemarks;

  // By birth disease
  bool congenitalDisorder;
  String congenitalDisorderRemarks;

  // Psychiatric issues
  bool psychiatricIssues;
  String psychiatricRemarks;

  // illness or operation
  bool hadSurgeries;
  String operationRemarks;

  // alcohol
  bool alcohol;
  String alcoholRemarks;

  // smoke
  bool smoke;
  String smokeRemarks;

  // sugar
  bool sugar;
  int yearsSugar;
  String sugarRemarks;

  // BP
  bool bp;
  String bpRemarks;

  // Cancer
  bool cancer;
  String cancerRemarks;

  // Heart
  bool heartDiseases;
  String heartRemarks;

  // Tumour
  bool tumour;
  String tumourRemarks;

  // in ms
  double height;

  // in kgs
  double weight;

  // weight(kg)/[height(in meters)]*[height(in meters)]
  double bmi;

  String otherIllness;

  Fitness(
      {this.bloodGroup,
      this.visionRemarks,
      this.csRed = false,
      this.csBlue = false,
      this.csGreen = false,
      this.cs24 = false,
      this.cs20 = false,
      this.cs16 = false,
      this.cs12 = false,
      this.cs8 = false,
      this.visionR,
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
