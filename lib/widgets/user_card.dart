import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utilities/bday.dart';

class UserCard extends StatelessWidget {
  final User user;
  final int userIndex;

  UserCard(this.user, this.userIndex);

  Widget genToText(User user) {
    if (user.gender == 0) {
      return Text('Mand');
    } else if (user.gender == 1) {
      return Text('Kvinde');
    }
    return Text('Andet');
  }

  @override
  Widget build(BuildContext context) {
    String age = bdayToAge(user.birthday) >= 18
        ? bdayToAge(user.birthday).toString()
        : '!?';

    return Card(
      child: Column(
        children: <Widget>[
          user.hasPicture
              ? FadeInImage(
                  image: NetworkImage(user.picture[0]),
                  height: 300.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/noPic.png'),
                )
              : Image.asset('assets/images/noPic.png'),
          Row(children: <Widget>[
            Text(user.firstName),
            genToText(user),
            Text(
              age,
              style: TextStyle(
                fontSize: 24,
              ),
            )
          ])
        ],
      ),
    );
  }
}
