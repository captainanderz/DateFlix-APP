import 'package:flutter/material.dart';
//4.2.1
class User {
  final int userId;
  final String firstName;
  final DateTime birthday;
  final int gender;
  final String description;
  final List<String> picture;
  final bool hasPicture;
  final String city;
//4.2.1.2
  User(
      {@required this.userId,
      @required this.firstName,
      @required this.birthday,
      @required this.gender,
      this.description,
      this.picture,
      this.hasPicture,
      this.city,});
}
