import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          'Dateflix',
          style: TextStyle(color: Colors.white70),
        ),
        leading: Icon(
          Icons.menu,
          color: Colors.white70,
        ),
        backgroundColor: Color.fromRGBO(38, 35, 35, 1),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Se alle brugere'),
              onPressed: () {
                Navigator.pushNamed(context, '/listUsers');
              },
            ),
            ScopedModelDescendant(
                builder: (BuildContext context, Widget child, MainModel model) {
              return RaisedButton(
                child: Text('Like test'),
                onPressed: () {
                },
              );
            }),
          ],
        )),
      ),
    );
  }
}
