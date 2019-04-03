import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import '../scoped_models/main.dart';
import '../utilities/bday.dart';

//7.1.1
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

//7.1.1.1
  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              color: Colors.red,
              onPressed: () {
                model.users.removeAt(userIndex);
              },
            ),
            IconButton(
              icon: Icon(Icons.help),
              color: Colors.orangeAccent,
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(Icons.check_circle),
                color: Colors.green,
                onPressed: () async {
                  model.users.removeAt(userIndex);
                  bool matched =
                      await model.likeProfile(model.user.userId, user.userId);
                  if (matched) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          AlertDialog(
                            title: Text('Det er et match!'),
                            content: Text('Det er et match'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Nice'),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            ],
                          );
                        });
                  }
                })
          ],
        );
      },
    );
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

  //7.1.1.2
  @override
  Widget build(BuildContext context) {
    String age = bdayToAge(user.birthday) >= 18
        ? bdayToAge(user.birthday).toString()
        : '!?';

    return Card(color: Color.fromRGBO(38, 34, 34, 1),
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
            Text(user.firstName == null ? 'FEJL' : user.firstName),
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
