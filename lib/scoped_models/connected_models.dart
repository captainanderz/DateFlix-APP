import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/user.dart';
import '../models/local_user.dart';
import '../utilities/bday.dart';

mixin ConnectedModels on Model {
  List<User> _users = [];
  bool isLoading = false;
  LocalUser _authenticatedUser;

  final Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };
}

mixin LocalUserModel on ConnectedModels {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  LocalUser get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    isLoading = true;
    notifyListeners();
    bool hasError = true;
    String message = 'Somthing went wrong';

    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/users/authenticate',
        headers: header,
        body: json.encode({"email": email, "password": password}));
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    isLoading = false;
    notifyListeners();
    if (!responseData.containsKey('message')) {
      hasError = false;
      message = 'Login successful';

      DateTime bday = stringToDateTime(responseData['birthday']);

      _authenticatedUser = LocalUser(
          userId: responseData['id'],
          firstName: responseData['firstName'],
          birthday: bday,
          email: responseData['email'],
          description: responseData['description'],
          gender: responseData['gender'],
          hasPicture: false,
          city: responseData['city'],
          token: responseData['token']);
      print('LocalUser created');
      setAuthTimeout(60);
      print('Setting AuthTimeout');
      _userSubject.add(true);
      print('Event true');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final DateTime now = DateTime.now();
      final DateTime expirationDate = now.add(Duration(seconds: 60));
      prefs.setString('userId', responseData['id'].toString());
      prefs.setString('email', responseData['email']);
      prefs.setString('token', responseData['token']);
      prefs.setString('expirationDate', expirationDate.toIso8601String());
    } else if (responseData['message'] == 'Username or password is incorrect') {
      hasError = false;
      message = 'Forkert brugernavn eller adgangskode';
    }
    return {'success': !hasError, 'message': message};
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expirationDateString = prefs.getString('expirationDate');
    if (token != null) {
      final DateTime now = DateTime.now();
      final DateTime parsedExpirationDate =
          DateTime.parse(expirationDateString);
      if (parsedExpirationDate.isBefore(now)) {
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('email');
      final String userId = prefs.getString('userId');
      final int tokenLifeSpan = parsedExpirationDate.difference(now).inSeconds;
      _authenticatedUser =
          LocalUser(userId: int.parse(userId), email: userEmail, token: token);
      _userSubject.add(true);
      setAuthTimeout(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null;
    _authTimer.toString();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('email');
  }

  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), logout);
  }
}

mixin UsersModel on ConnectedModels {
  List<User> get users {
    return List.from(_users);
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) async {
    isLoading = true;
    notifyListeners();
    final String bday =
        user['year'] + '-' + user['month'] + '-' + user['day'] + 'T00:00:00';
    final Map<String, dynamic> newUser = {
      'firstName': user['firstname'],
      'lastName': 'TestFromApp',
      'username': user['username'],
      'password': user['password'],
      'birthday': bday
    };

    bool success = false;
    String title = 'Fejl';
    String message = 'Hovsa... Noget gik galt';

    var body = jsonEncode(newUser);

    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/users/register',
        body: body,
        headers: header);

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      title = 'Success!';
      message = 'Bruger oprettet';
    }
    isLoading = false;
    notifyListeners();
    return {'success': success, 'title': title, 'message': message};
  }

  Future<Null> fetchUsers() {
    isLoading = true;

    notifyListeners();
    return http
        .get('http://dateflix.captainanderz.com/api/users/getall',
            headers: header)
        .then<Null>((http.Response response) {
      final List<User> fetchedUsers = [];
      print('STILL ENCODEDED: ' + response.body);
      print('DECODED: ');
      print(json.decode(response.body));
      final List<dynamic> userListData = json.decode(response.body);
      print('NEW TEST: ');
      print(userListData[0]);
      if (userListData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      userListData.forEach((dynamic userData) {
        print(userData);
        final User user = User(
            userId: userData['id'],
            firstName: userData['firstName'],
            birthday: DateTime.parse(userData['birthday']),
            gender: userData[9],
            picture: userData[7],
            hasPicture: false,
            city: userData[8],
            description: userData[10]);
        fetchedUsers.add(user);
      });
      _users = fetchedUsers;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> likeProfile(int userId, int likedId) async {
    isLoading = true;
    notifyListeners();

    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/date/like',
        headers: header,
        body: json.encode({"userId": userId, "likedId": likedId}));
    print(response);
    if (response.body.isNotEmpty) {
      print(json.decode(response.body));
      if(json.decode(response.body))
      {
        return true;
      }
    }
    return false;
  }
}
