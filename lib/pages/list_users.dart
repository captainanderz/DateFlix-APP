import 'package:flutter/material.dart';

class ListUsersPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _UserListStage();
  }
}

class _UserListStage extends State<ListUsersPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Dateflix brugere'),),body: Container());
  }
}