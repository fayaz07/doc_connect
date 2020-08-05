import 'package:hive/hive.dart';

part 'author.g.dart';

@HiveType(typeId: 7)
class Author {
  @HiveField(0)
  String gender;

  @HiveField(1)
  String speciality;

  @HiveField(2)
  String profession;

  @HiveField(3)
  int age;

  @HiveField(4)
  bool isDoctor;

  @HiveField(5)
  String firstName;

  @HiveField(6)
  String lastName;

  Author(
      {this.gender,
      this.firstName,
      this.lastName,
      this.speciality,
      this.profession,
      this.age,
      this.isDoctor});

  factory Author.fromJSON(var map) {
    return map == null
        ? Author()
        : Author(
            firstName: map["first_name"],
            lastName: map["last_name"],
            age: int.parse(map["age"].toString()) ?? 0,
            isDoctor: map["is_doctor"] ?? false,
            gender: map["gender"],
            speciality: map["speciality"],
            profession: map["profession"],
          );
  }

  @override
  String toString() {
    return 'Author{gender: $gender, speciality: $speciality, profession: $profession, age: $age, isDoctor: $isDoctor, firstName: $firstName, lastName: $lastName}';
  }
}
