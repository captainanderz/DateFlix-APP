import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../models/user.dart';
import '../models/local_user.dart';
import '../utilities/bday.dart';
import '../scoped_models/main.dart';
import '../pages/match.dart';

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

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.red,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.help),
            color: Colors.orangeAccent,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.check_circle),
            color: Colors.green,
            onPressed: () {
            model.likeProfile(model.user.userId, user.userId);
            },
          )
        ],
      );
    });
  }

// if ((await model.likeProfile(model.user.userId, user.userId)) ==
//                   true) {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     AlertDialog(
//                       title: Text('Det er et match!'),
//                       content: _buildMatchContent(context, user, model.user),
//                       actions: <Widget>[
//                         FlatButton(
//                           child: Text('Nice'),
//                           onPressed: () => Navigator.of(context).pop(),
//                         )
//                       ],
//                     );
//                   },
//                 );
//               }

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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(user.firstName),
            genToText(user),
            Text(
              age,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ]),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
