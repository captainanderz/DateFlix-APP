import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';
import 'package:signalr_client/signalr_client.dart';

import '../models/user.dart';
import '../models/local_user.dart';
import '../models/message.dart';
import '../utilities/bday.dart';

//5.1.1
mixin ConnectedModels on Model {
  List<User> _users = [];
  List<User> _matches = [];
  List<Message> messages = [];
  User matched;
  bool isLoading = false;
  LocalUser _authenticatedUser;

  Map<String, String> header = {
    "Accept": "application/json",
    "content-type": "application/json"
  };
}

//5.1.2
mixin LocalUserModel on ConnectedModels {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  LocalUser get user {
    return _authenticatedUser;
  }

  //5.1.2.1
  Future<Map<String, dynamic>> authenticate(
      String email, String password) async {
    isLoading = true;
    notifyListeners();
    bool hasError = true;
    String message = 'Noget gik galt';

    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/users/authenticate',
        headers: header,
        body: json.encode({"email": email, "password": password}));
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    print(responseData['message']);
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 400 && !responseData.containsKey('message')) {
      return {'success': !hasError, 'message': message};
    }
    if (!responseData.containsKey('message')) {
      hasError = false;
      message = 'Login successful';
      DateTime bday = stringToDateTime(responseData['birthday']);

      List<int> preferences = [];
      if (responseData['userPreference'] != null) {
        preferences = [
          responseData['userPreference'][0],
          responseData['userPreference'][1],
          responseData['userPreference'][2]
        ];
      } else {
        message = 'Preferences not set';
      }
      _authenticatedUser = LocalUser(
          userId: responseData['id'],
          firstName: responseData['firstName'],
          birthday: bday,
          email: responseData['email'],
          description: responseData['description'],
          gender: responseData['gender'],
          hasPicture: false,
          prefs: preferences,
          city: responseData['city'],
          token: responseData['token']);
      print('LocalUser created');
      setAuthTimeout(60);
      print('Setting AuthTimeout');
      _userSubject.add(true);
      print('Event true');
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final DateTime now = DateTime.now();
      final DateTime expirationDate = now.add(Duration(minutes: 60));
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

  //5.1.2.2
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

  //5.1.2.3
  void logout() async {
    _authenticatedUser = null;
    _authTimer.toString();
    _userSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    header.remove('Authorization');
    prefs.remove('token');
    prefs.remove('userId');
    prefs.remove('email');
  }

  //5.1.2.4
  void setAuthTimeout(int time) {
    _authTimer = Timer(Duration(minutes: time), logout);
  }
}

//5.1.3
mixin UsersModel on ConnectedModels {
  List<User> get users {
    return List.from(_users);
  }

  List<User> get matches {
    return List.from(_matches);
  }

  //5.1.3.1
  Future<Map<String, dynamic>> deleteUser() async {
    bool success = false;
    String title = 'Fejl';
    String message = 'Hovsa... Noget gik galt';

    header.putIfAbsent(
        'Authorization', () => 'Bearer ' + _authenticatedUser.token);
    print(header);

    http.Response response = await http.delete(
        'http://dateflix.captainanderz.com/api/users/' +
            _authenticatedUser.userId.toString());
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      title = 'Bruger slettet';
      message = 'Vi håber du vender tilbage igen';
    }
    return {'success': success, 'title': title, 'message': message};
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) async {
    isLoading = true;
    notifyListeners();
    final String bday =
        user['year'] + '-' + user['month'] + '-' + user['day'] + 'T00:00:00';
    print(bday);
    final Map<String, dynamic> newUser = {
      'firstName': user['firstname'],
      'lastName': 'TestFromApp',
      'email': user['email'],
      'gender': user['gender'],
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

  Future<Map<String, dynamic>> setupUserPreferences(
      Map<String, dynamic> prefs) async {
    isLoading = true;
    notifyListeners();

    bool success = false;
    String title = 'Fejl';
    String message = 'Hovsa... Noget gik galt';

    var body = json.encode(prefs);

    header.putIfAbsent(
        'Authorization', () => 'Bearer ' + _authenticatedUser.token);

    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/users/UpdateUserPreference?userid=' +
            _authenticatedUser.userId.toString(),
        body: body,
        headers: header);

    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      title = 'Success!';
      message = 'Indstillinger sat';
    }
    isLoading = false;
    notifyListeners();
    return {'success': success, 'title': title, 'message': message};
  }

  Future<Null> fetchUsers() {
    isLoading = true;
    notifyListeners();

    header.putIfAbsent(
        'Authorization', () => 'Bearer ' + _authenticatedUser.token);
    print(header);

    String url =
        'http://dateflix.captainanderz.com/api/date/GetMatchingUsers?userid=' +
            _authenticatedUser.userId.toString();
    return http.get(url, headers: header).then<Null>((http.Response response) {
      final List<User> fetchedUsers = [];
      final List<dynamic> userListData = json.decode(response.body);
      if (userListData == null) {
        isLoading = false;
        notifyListeners();
        print('Empty list');
        return;
      }
      userListData.forEach((dynamic userData) {
        print(userData);
        final User user = User(
            userId: userData['id'],
            firstName: userData['firstName'],
            birthday: stringToDateTime(userData['birthday']),
            email: userData['email'],
            gender: userData['gender'],
            picture: userData[7],
            hasPicture: false,
            city: userData[8],
            description: userData[10]);
        fetchedUsers.add(user);
      });
      _users = fetchedUsers;
      print('List created');
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      print('Error');
      print(error);
      isLoading = false;
      notifyListeners();
      return;
    });
  }

  String connectionId;

  Future<Null> fetchMatches() {
    isLoading = true;
    String id = _authenticatedUser.userId.toString();
    notifyListeners();
    //await getConnectionId();
    header.putIfAbsent(
        'Authorization', () => 'Bearer ' + _authenticatedUser.token);
    return http
        .get('http://dateflix.captainanderz.com/api/date/matches?userid=' + id,
            headers: header)
        .then<Null>((http.Response response) {
      final List<User> fetchedMatches = [];
      //print('STILL ENCODEDED: ' + response.body);
      //print('DECODED: ');
      //print(json.decode(response.body));
      final List<dynamic> userListData = json.decode(response.body);
      //print('NEW TEST: ');
      //print(userListData[0]);
      if (userListData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      userListData.forEach((dynamic userData) {
        //print(userData);
        final User user = User(
            userId: userData['id'],
            firstName: userData['firstName'],
            birthday: DateTime.parse(userData['birthday']),
            email: userData['email'],
            gender: userData[9],
            picture: userData[7],
            hasPicture: false,
            city: userData[8],
            description: userData[10]);
        fetchedMatches.add(user);
      });
      _matches = fetchedMatches;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      return;
    });
  }

  //5.1.3.4
  Future<bool> likeProfile(int userId, int likedId) async {
    print(userId);
    print(likedId);
    isLoading = true;
    notifyListeners();

    print(json.encode({"UserId": userId, "LikedId": likedId}));
    
    header.putIfAbsent(
        'Authorization', () => 'Bearer ' + _authenticatedUser.token);
    http.Response response = await http.post(
        'http://dateflix.captainanderz.com/api/date/like',
        headers: header,
        body: json.encode({"UserId": userId, "LikedId": likedId}));
    print(response);
print(response.body);
    isLoading = false;
    notifyListeners();
    return false;
  }

  HubConnection connection;

  void _recieveMessage(List<Object> args) {
    final String senderName = args[0];
    final String message = args[1];
    print(senderName + ': ' + message);
  }

  Future<Null> startChatConnection() async {
    if (connection == null) {
      print('Connection is null. Building new conection');
      connection = new HubConnectionBuilder()
          .withUrl('http://dateflix.captainanderz.com/privatechathub?email=' +
              _authenticatedUser.email)
          .build();
      connection.onclose((error) => {print(error)});
      connection.on("ReceiveMessage", _recieveMessage);
    }
    if (connection.state != HubConnectionState.Connected) {
      print('Connection build, but not connected');
      await connection.start();
    }
  }

  Future<Null> getConnectionId() async {
    String newId;
    await startChatConnection().then((t) async {
      newId = (await connection.invoke("GetConnectionId")).toString();
      print(newId);
      connectionId = newId;
    });
  }

  buildMessageList(User user) async {
    isLoading = true;
    notifyListeners();
    List<dynamic> messagesData = await getMessages(user);

    if (messagesData != null) {
      messagesData.forEach((dynamic messageData) {
        print('Adding messages to list');
        String name;
        if (messageData['receiverFirstname'] == user.email) {
          name = _authenticatedUser.firstName;
        } else {
          name = user.firstName;
        }
        final Message message =
            Message(name: name, message: messageData['message']);
        messages.add(message);
      });
      isLoading = false;
      notifyListeners();
      print('Single object of messages');
      print(messages[0]);
    }
  }

  Future<List<dynamic>> getMessages(User user) async =>
      await getConnectionId().then((void message) async {
        print('Calling GetMessages with ' +
            _authenticatedUser.email +
            ', ' +
            user.email +
            ' as parameters');

        List<dynamic> messageData = (await connection.invoke("GetMessages",
            args: <String>[_authenticatedUser.email, user.email]));
        return messageData;
      });
}
