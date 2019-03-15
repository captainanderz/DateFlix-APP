import 'package:flutter/material.dart';


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

  LocalUser(
      {@required this.userId,
      @required this.firstName,
      @required this.birthday,
      @required this.email,
      @required this.gender,
      this.description,
      this.picture,
      this.hasPicture,
      this.city,
      @required this.token});
}
