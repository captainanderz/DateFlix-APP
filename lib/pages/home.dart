import 'package:flutter/material.dart';

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
    );
  }
}
