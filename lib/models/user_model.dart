import '../enums/app_enums.dart';

// A Model is like a blueprint/template for your data
// Every user that registers will be stored as a UserModel object
// Think of it like a form that holds one person's information

class UserModel {
  final String fullName;
  final String email;
  final String password;
  final Gender gender;

  // 'required' means all fields MUST be provided
  // 'final' means once set, they cannot be changed
  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.gender,
  });
}