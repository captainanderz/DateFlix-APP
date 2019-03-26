import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      appBar: new AppBar(
        brightness: Brightness.dark,
        elevation: 1.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: new Text(
          "Home",
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: new Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
        ),
        automaticallyImplyLeading: false,
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
                    RaisedButton(
                  child: Text('Se matches'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/matches');
                  },
                )
              ],
            )),
      ),
    );
  }
}
