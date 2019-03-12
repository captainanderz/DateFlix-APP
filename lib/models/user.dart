import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class User {
  final int userId;
  final String firstName;
  final DateTime birthday;
  final int gender;
  final String description;
  final List<String> picture;
  final bool hasPicture;
  final String city;

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
