import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './user_card.dart';
import '../scoped_models/main.dart';
import '../models/user.dart';

//7.2.1
class Users extends StatelessWidget {

  Widget _buildUserList(List<User> users) {
    Widget userCard;
    if(users.length > 0) {
      userCard = ListView.builder(
        itemBuilder: (BuildContext context,int index) =>
        UserCard(users[index], index),
        itemCount: users.length,
      );
    } else {
      userCard = Center(child: Text('Ingen brugere fundet FRA USERS.DART'),);
    }
    return userCard;
  }

  //7.2.1.1
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildUserList(model.users);
    },);
  }
}