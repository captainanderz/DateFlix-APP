import 'package:flutter/material.dart';

//4.1.1
class LocalUser {
  final int userId;
  final String firstName;
  final DateTime birthday;
  final int gender;
  final String email;
  final String description;
  final List<String> picture;
  final bool hasPicture;
  final String city;
  final String token;
//4.1.2
  LocalUser(
      {@required this.userId,
      this.firstName,
      this.birthday,
      @required this.email,
      this.gender,
      this.description,
      this.picture,
      this.hasPicture,
      this.city,
      @required this.token});
}
