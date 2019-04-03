import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../widgets/users.dart';

//3.8.1
class ListUsersPage extends StatefulWidget {
  final MainModel model;

  ListUsersPage(this.model);
//3.8.1.1
  @override
  State<StatefulWidget> createState() {
    return _UserListState();
  }
}

//3.8.2
class _UserListState extends State<ListUsersPage> {
  //3.9.2.1
  @override
  void initState() {
    widget.model.fetchUsers();
    super.initState();
  }

//3.8.2.2
  Widget _buildUserList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
        child: Text('Ingen brugere fundet FRA LIST_USERS.DART'),
      );
      if (model.users.length >= 0 && !model.isLoading) {
        content = Users();
      } else if (model.isLoading) {
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchUsers,
        child: content,
      );
    });
  }

//3.9.2.3
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          brightness: Brightness.dark,
          title: Text(
            'Dateflix brugere',
            style: TextStyle(
                color: Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
          ),
        ),
        body: _buildUserList());
  }
}
