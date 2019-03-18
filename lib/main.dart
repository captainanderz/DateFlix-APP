import 'package:dateflix/pages/acc_settings.dart';
import 'package:dateflix/pages/account.dart';
import 'package:dateflix/pages/chat.dart';
import 'package:dateflix/pages/edit_profil.dart';
import 'package:dateflix/pages/home.dart';
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
            '/home':(BuildContext context) => !_isAuthenticated ? FrontPage() : HomePage,
            '/chat':(BuildContext context) => !_isAuthenticated ? FrontPage() : Chat,
            '/account':(BuildContext context) => !_isAuthenticated ? FrontPage() : Profile,
            '/acc_setting':(BuildContext context) => !_isAuthenticated ? FrontPage() : Acc_Setting,
            '/edit_profil':(BuildContext context) => !_isAuthenticated ? FrontPage() : Edit_Profil,
          },
        ),
      ),
    );
  }
}
