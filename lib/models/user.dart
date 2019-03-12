import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class User extends Model {
  final String userId;
  final String firstName;
  final String birthday;
  final int gender;
  final String description;
  final String picture;
  final bool hasPicture;

  User(
      {@required this.userId,
      @required this.firstName,
      @required this.birthday,
      @required this.gender,
      this.description,
      this.picture,
      this.hasPicture});
}
