import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/local_user.dart';

mixin ConnectedModels on Model {
  List<User> _users = [];
  bool isLoading = false;
  LocalUser _authenticatedUser;

  final Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

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
}

mixin LocalUserModel on ConnectedModels {
  Timer _authTimer;

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
        body: json.encode({"username": email, "password": password}));
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    isLoading =false;
    notifyListeners();
    if(!responseData.containsKey('message'))
    {
      hasError = false;
      message = 'Login successful';

      _authenticatedUser = LocalUser(
        userId: responseData['id'],
        firstName: responseData['firstName'],
        birthday: responseData['birthday'],
        email: responseData['email'],
        description: responseData['description'],
        gender: responseData['gender'],
        hasPicture: false,
        city: responseData['city'],
        token: responseData['token']
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', responseData['id']);
      prefs.setString('email', responseData['email']);
      prefs.setString('token', responseData['token']);

    } else if (responseData['message'] == 'Username or password is incorrect') {
      hasError = false;
      message = 'Forkert brugernavn eller adgangskode';
    }
    return {'success': !hasError, 'message': message};
  }

  

  void logout() async {
    _authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('email');
  }
}

mixin UsersModel on ConnectedModels {
  List<User> get users {
    return List.from(_users);
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
}
