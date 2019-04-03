import 'package:flutter/material.dart';
import './list_users.dart';
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
        bottomNavigationBar: Material(
          color: Color.fromRGBO(38, 35, 35, 1),
          child: TabBar(
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).primaryColor,
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
        ),
        body: TabBarView(
          children: <Widget>[ListUsersPage(model), Chat(model), Profile()],
        ),
      ),
    );
  }
}
