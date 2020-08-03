import 'package:doc_connect/data_models/user_review.dart';

class User {
  String id, email, firstName, lastName, knownLanguages;

  bool isDoctor;
  bool availableForCall;
  bool availableForChat;

  String hospitalName, workplace;

  String photoUrl, symptoms;

  String availability, website, profession, gender, location;
  double latitude, longitude;

  String speciality;

  int age;
  DateTime createdOn;

  double popularity;

  List<UserReview> reviews;

  String preMedicalReportId;

  Map<dynamic, dynamic> additionalData;

  User({
    this.id,
    this.email,
    this.isDoctor = false,
    this.createdOn,
    this.availability,
    this.availableForCall = false,
    this.availableForChat = false,
    this.firstName,
    this.lastName,
    this.website,
    this.profession,
    this.speciality,
    this.gender,
    this.location,
    this.latitude,
    this.longitude,
    this.age,
    this.popularity,
    this.knownLanguages,
    this.reviews,
    this.hospitalName,
    this.workplace,
    this.photoUrl,
    this.symptoms,
    this.additionalData,
    this.preMedicalReportId,
  });

  static User fromJSON(var map) {
    return User(
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      id: map['user_id'],
      createdOn: map['created_on'] != null
          ? DateTime.parse(map['created_on'])
          : DateTime.now(),
      photoUrl: map['photo_url'],
      isDoctor: map['is_doctor'] ?? false,
      availability: map['availability'],
      gender: map['gender'],
      knownLanguages: map['known_languages'],
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      profession: map['profession'],
      website: map['website'],
      additionalData: map['additional_data'],
      age: int.parse(map['age'] != null ? map['age'].toString() : '0'),
      hospitalName: map['hospital_name'],
      symptoms: map['symptoms'],
      workplace: map['workplace'],
      availableForCall: map['available_for_call'] ?? false,
      speciality: map['speciality'],
      availableForChat: map['available_for_chat'] ?? false,
      popularity: double.parse(
          map['popularity'] != null ? map['popularity'].toString() : '0.0'),
      reviews: UserReview.fromJSONList(map['reviews']),
      preMedicalReportId: map["medical_report"],
    );
  }

  static Map<String, dynamic> toJSON(User user) {
    return {
      "first_name": user.firstName,
      "last_name": user.lastName,
//      "email": user.email,
//      "user_id": user.id,
//      "created_on": user.createdOn,
      "photo_url": user.photoUrl,
      "availability": user.availability,
      "gender": user.gender,
      "known_languages": user.knownLanguages,
      "location": user.location,
      "latitude": user.latitude,
      "longitude": user.longitude,
      "profession": user.profession,
      "website": user.website,
//      "is_doctor": user.isDoctor,
      "additional_data": user.additionalData,
      "age": user.age,
      "hospital_name": user.hospitalName,
      "symptoms": user.symptoms,
      "workplace": user.workplace,
      "available_for_call": user.availableForCall,
      "speciality": user.speciality,
      "available_for_chat": user.availableForChat,
    };
  }

  static Map<String, User> fromJSONList(var jsonList) {
    Map<String, User> users = Map();
    for (var c in jsonList) {
      final u = User.fromJSON(c);
      users[u.id] = u;
    }
    return users;
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, firstName: $firstName, '
        'lastName: $lastName, knownLanguages: $knownLanguages, '
        'isDoctor: $isDoctor, availableForCall: $availableForCall, '
        'availableForChat: $availableForChat, hospitalName: $hospitalName,'
        'workplace: $workplace, photoUrl: $photoUrl, symptoms: $symptoms,'
        'availability: $availability, website: $website,'
        'profession: $profession, gender: $gender, location: $location, '
        'latitude: $latitude, longitude: $longitude, speciality: $speciality,'
        'age: $age, createdOn: $createdOn, popularity: $popularity,'
        'reviews: $reviews, additionalData: $additionalData}';
  }
}
