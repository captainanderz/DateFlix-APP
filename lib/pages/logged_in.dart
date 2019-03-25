import 'package:flutter/material.dart';

import './home.dart';
import './account.dart';
import './chat.dart';
import '../scoped_models/main.dart';
//3.10.1
class LoggedInPage extends StatelessWidget {
  final MainModel model;
//3.10.1.1
  LoggedInPage(this.model);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
