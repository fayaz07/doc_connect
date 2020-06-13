import 'package:doc_connect/data_models/user_review.dart';

class User {
  // ignore: non_constant_identifier_names
  String id, email, first_name, last_name, known_languages;

  // ignore: non_constant_identifier_names
  bool is_doctor;
  bool available_for_call;
  bool available_for_chat;

  String hospital_name, workplace;

  // ignore: non_constant_identifier_names
  String photo_url, symptoms;

  String availability, website, profession, gender, location, speciality;

  int age;
  DateTime created_on;

  double popularity;

  List<UserReview> reviews;

  // ignore: non_constant_identifier_names
  Map<dynamic, dynamic> additional_data;

  User({
    this.id,
    this.email,
    this.is_doctor,
    this.created_on,
    this.availability,
    this.available_for_call,
    this.available_for_chat,
    this.first_name,
    this.last_name,
    this.website,
    this.profession,
    this.speciality,
    this.gender,
    this.location,
    this.age,
    this.popularity,
    this.known_languages,
    this.reviews,
    this.hospital_name,
    this.workplace,
    this.photo_url,
    this.symptoms,
    this.additional_data,
  });

  factory User.fromJSON(Map<String, dynamic> map) {
    return User(
      first_name: map['first_name'],
      last_name: map['last_name'],
      email: map['email'],
      id: map['user_id'],
      created_on: map['created_on'] != null
          ? DateTime.parse(map['created_on'])
          : DateTime.now(),
      photo_url: map['photo_url'],
      is_doctor: map['is_doctor'],
      availability: map['availability'],
      gender: map['gender'],
      known_languages: map['known_languages'],
      location: map['location'],
      profession: map['profession'],
      website: map['website'],
      additional_data: map['additional_data'],
      age: int.parse(map['age'] != null ? map['age'].toString() : '0'),
      hospital_name: map['hospital_name'],
      symptoms: map['symptoms'],
      workplace: map['workplace'],
      available_for_call: map['available_for_call'],
      speciality: map['speciality'],
      available_for_chat: map['available_for_chat'],
      popularity: double.parse(
          map['popularity'] != null ? map['popularity'].toString() : '0.0'),
      reviews: UserReview.fromJSONList(map['reviews']),
    );
  }

  static Map<String, dynamic> toJSON(User user) {
    return {
      "first_name": user.first_name,
      "last_name": user.last_name,
      "email": user.email,
      "user_id": user.id,
      "created_on": user.created_on,
      "photo_url": user.photo_url,
      "availability": user.availability,
      "gender": user.gender,
      "known_languages": user.known_languages,
      "location": user.location,
      "profession": user.profession,
      "website": user.website,
      "is_doctor": user.is_doctor,
      "additional_data": user.additional_data,
      "age": user.age,
      "hospital_name": user.hospital_name,
      "symptoms": user.symptoms,
      "workplace": user.workplace,
      "available_for_call": user.available_for_call,
      "speciality": user.speciality,
      "available_for_chat": user.available_for_chat,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, created_on: $created_on, first_name: $first_name, last_name: $last_name, known_languages: $known_languages, is_doctor: $is_doctor, hospital_name: $hospital_name, workplace: $workplace, photo_url: $photo_url, symptoms: $symptoms, availability: $availability, website: $website, profession: $profession, gender: $gender, location: $location, age: $age, additional_data: $additional_data}';
  }
}
