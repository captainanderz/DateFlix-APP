import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard(this.user);

Widget genToIcon(User user)
{
  if(user.gender == 0)  
  return Image.asset(name);
}
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          user.hasPicture
              ? FadeInImage(
                  image: NetworkImage(user.picture),
                  height: 300.0,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/noPic.png'),
                )
              : AssetImage('assets/images/noPic.png'),
              Row(children: <Widget>[Text(user.firstName),])
        ],
      ),
    );
  }
}
