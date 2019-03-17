import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/front.dart';
import './pages/auth.dart';
import './pages/logged_in.dart';
import './pages/create_user.dart';
import './pages/list_users.dart';
import './scoped_models/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel model = MainModel();
  bool _isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    

    return ScopedModel<MainModel>(
      model: model,
      child: Container(
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Color.fromRGBO(34, 31, 31, 1),
            primaryColor: Colors.white,
            accentColor: Colors.red[900],
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: Color.fromRGBO(38, 35, 35, 1)),
            fontFamily: 'Bebas',
          ),
          routes: {
            '/': (BuildContext context) => !_isAuthenticated ? FrontPage() : LoggedInPage,
            '/auth': (BuildContext context) => AuthPage(),
            '/loggedIn': (BuildContext context) => !_isAuthenticated ? FrontPage() : LoggedInPage(),
            '/createUser': (BuildContext context) => CreateUserPage(),
            '/listUsers': (BuildContext context) => !_isAuthenticated ? FrontPage() : ListUsersPage(model),
          },
        ),
      ),
    );
  }
}
