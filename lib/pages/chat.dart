import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> {
  TabController controller;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          elevation: 1.0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: new Text(
            "Matches", textAlign: TextAlign.center,
            style: new TextStyle(
                color: new Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
          ),
          automaticallyImplyLeading: false,
        ),
        body: new Container(
            width: screenSize.width,
            height: screenSize.height,
            color: Theme.of(context).backgroundColor,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration:
                  new BoxDecoration(shape: BoxShape.circle),
                ),
                new Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text(
                    "There are no matches!",
                    style: new TextStyle(
                      color: Colors.white70,
                        fontFamily: "Bebas",
                        fontSize: 15.0,
                        fontWeight: FontWeight.w100,
                        letterSpacing: 1.0),
                  ),
                )
              ],
            )));
  }
}
