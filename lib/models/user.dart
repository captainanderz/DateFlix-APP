import 'package:flutter/material.dart';

class User {
  final int userId;
  final String firstName;
  final String email;
  final DateTime birthday;
  final int gender;
  final String description;
  final List<String> picture;
  final bool hasPicture;
  final String city;

  User(
      {@required this.userId,
      @required this.firstName,
      @required this.email,
      @required this.birthday,
      @required this.gender,
      this.description,
      this.picture,
      this.hasPicture,
      this.city,});
}
