import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  final String id;
  final String fistName;
  final String lastName;
  final String email;
  final String age;

  UserModel({
    required this.id,
    required this.fistName,
    required this.lastName,
    required this.email,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fistName: json['fistName'],
      lastName: json['lastName'],
      email: json['email'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fistName': fistName,
      'lastName': lastName,
      'email': email,
      'age': age,
    };
  }
}
