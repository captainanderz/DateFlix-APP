import 'package:flutter/material.dart';

class CreatedUser {
  final String name;
  final String email;
  final String password;
  final String image;
  final int gender;
  final String bio;
  final String city;

  CreatedUser(
      {@required this.name,
      @required this.email,
      @required this.password,
      this.image,
      @required this.gender,
      this.bio,
      this.city});
}
