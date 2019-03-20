import 'package:flutter/material.dart';

import './home.dart';
import './account.dart';
import './chat.dart';
import '../scoped_models/main.dart';

class LoggedInPage extends StatelessWidget {
  final MainModel model;

  LoggedInPage(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color.fromRGBO(38, 35, 35, 1),
          title: Text('Matches', style: TextStyle(color: Colors.white),)
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.message),
            ),
            Tab(
              icon: Icon(Icons.account_box),
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[HomePage(), Chat(model), Profile()],
        ),
      ),
    );
  }
}
