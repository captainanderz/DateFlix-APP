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
import './pages/matches.dart';

import './scoped_models/main.dart';

// 2.1
void main() {
  runApp(Dateflix());
}

// 2.2
class Dateflix extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DateflixState();
  }
}

// 2.3
class _DateflixState extends State<Dateflix> {
  final MainModel model = MainModel(); // Intanciate MainModel
  bool _isAuthenticated = false; // Assumes user is the authenticated at startup

// 2.3.1
  @override
  void initState() {
    model.autoAuthenticate();
    model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

// 2.3.2
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
          // All routes go here, for simplicity.
          routes: {
            '/': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : LoggedInPage(model),
            '/auth': (BuildContext context) => AuthPage(),
            '/loggedIn': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : LoggedInPage(model),
            '/createUser': (BuildContext context) => CreateUserPage(),
            '/listUsers': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : ListUsersPage(model),
            '/home': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : HomePage,
            '/chat': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : Chat(model),
            '/account': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : Profile,
            '/acc_setting': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : AccSettings(),
            '/edit_profil': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : EditProfile(),
            '/matches': (BuildContext context) =>
                !_isAuthenticated ? FrontPage() : MatchesListPage(model)
          },
        ),
      ),
    );
  }
}
