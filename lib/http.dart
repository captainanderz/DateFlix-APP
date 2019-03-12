import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './utilities/alert.dart';

void createUser(Map<String, dynamic> user, BuildContext context) {
    final String bday = user['year'] + '-' + user['month'] + '-' + user['day'] + 'T00:00:00';
    final Map<String, dynamic> newUser = {
      'firstName': user['firstname'],
      'lastName': 'TestFromApp',
      'username': user['username'],
      'password': user['password'],
      'birthday': bday
    };

    var body = jsonEncode(newUser);
    Map<String, String> header = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    print(body);
    http
        .post('http://dateflix.captainanderz.com/api/users/register',
            body: body, headers: header)
        .then(
      (http.Response response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertText('Succes!', 'Bruger oprettet');
            },
          );
        } else {
          print(response.statusCode);
          print(response.body);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertText('Hovsa', 'Bruger ikke oprettet');
            },
          );
        }
      },
    );
  }