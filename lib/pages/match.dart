import 'package:flutter/material.dart';

import '../models/local_user.dart';
import '../models/user.dart';

class MatchPage extends StatelessWidget {
  final User _user;
  final LocalUser _localUser;

  MatchPage(this._user, this._localUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _localUser.hasPicture
                      ? FadeInImage(
                          image: NetworkImage(_localUser.picture[0]),
                          height: 300.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/images/noPic.png'),
                        )
                      : Image.asset('assets/images/noPic.png'),
                  Text(_localUser.firstName)
                ],
              ),
              Column(
                children: <Widget>[
                  _user.hasPicture
                      ? FadeInImage(
                          image: NetworkImage(_user.picture[0]),
                          height: 300.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/images/noPic.png'),
                        )
                      : Image.asset('assets/images/noPic.png'),
                  Text(_user.firstName)
                ],
              )
            ],
          ),
          FlatButton(
            child: Text('Nice!'),
            onPressed: () => {Navigator.pop(context)},
          )
        ],
      ),
    );
  }
}
