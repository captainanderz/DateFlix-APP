import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../widgets/users.dart';
import '../models/user.dart';

class ListUsersPage extends StatefulWidget {
  final MainModel model;

  ListUsersPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _UserListStage();
  }
}

class _UserListStage extends State<ListUsersPage> {
  @override
  void initState() {
    widget.model.fetchUsers();
    super.initState();
  }



  Widget _buildUserList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          if(model.newMatch)
          {
            //showDialog();
          }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dateflix brugere'),
        ),
        body: _buildUserList());
  }
}
