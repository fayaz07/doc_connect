import 'package:doc_connect/data_models/user_review.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 10)
class User {
  @HiveField(0)
  String id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String knownLanguages;

  @HiveField(5)
  bool isDoctor;

  @HiveField(6)
  bool availableForCall;

  @HiveField(7)
  bool availableForChat;

  @HiveField(8)
  String hospitalName;

  @HiveField(9)
  String workplace;

  @HiveField(10)
  String photoUrl;

  @HiveField(11)
  String symptoms;

  @HiveField(12)
  String availability;

  @HiveField(13)
  String website;

  @HiveField(14)
  String profession;

  @HiveField(15)
  String gender;

  @HiveField(16)
  String location;

  @HiveField(17)
  double latitude;

  @HiveField(18)
  double longitude;

  @HiveField(19)
  String speciality;

  @HiveField(20)
  int age;

  @HiveField(21)
  DateTime createdAt;

  @HiveField(22)
  double popularity;

  @HiveField(23)
  List<UserReview> reviews;

  @HiveField(24)
  String preMedicalReportId;

  @HiveField(25)
  Map<dynamic, dynamic> additionalData;

  User({
    this.id,
    this.email,
    this.isDoctor = false,
    this.createdAt,
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
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
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
    if (jsonList == null) return users;
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
        'age: $age, createdOn: $createdAt, popularity: $popularity,'
        'reviews: $reviews, additionalData: $additionalData}';
  }
}
