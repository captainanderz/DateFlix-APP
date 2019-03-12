import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UsersModel extends Model {
  List<User> _users = [];
  bool isLoading = false;
  
  List<User> get users
  {
    return List.from(_users);
  }
  
  Future<Null> fetchUsers()
  {
    isLoading = true;

Map<String, String> header = {
          "Accept": "application/json",
          "content-type": "application/json"
        };

    notifyListeners();
    return http.get('http://dateflix.captainanderz.com/api/users/getall', headers: header).then<Null>((http.Response response) {
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
          description: userData[10]
        );
        fetchedUsers.add(user);
      });
      _users = fetchedUsers;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      return;
    })
    ;
  }

}