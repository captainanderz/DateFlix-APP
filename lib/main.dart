import 'package:flutter/material.dart';

import './pages/front.dart';
import './pages/auth.dart';
import './pages/logged_in.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
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
          '/': (BuildContext context) => FrontPage(),
          '/auth': (BuildContext context) => AuthPage(),
          '/loggedIn': (BuildContext context) => LoggedInPage(),
        },
      ),
    );
  }
}
