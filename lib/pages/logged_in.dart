import 'package:flutter/material.dart';
import 'package:dateflix/pages/home.dart';
import 'package:dateflix/pages/account.dart';
import 'package:dateflix/pages/chat.dart';


class LoggedInPage extends StatefulWidget {
  @override
  _LoggedInPage createState() => new _LoggedInPage();
}

class _LoggedInPage extends State<LoggedInPage> with SingleTickerProviderStateMixin {
  TabController controller;
  int index = 0;

  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    controller.addListener(() {
      this.setState(() {
        index = controller.index;
        // print(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;


    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: new Container(
        height: screenSize.height / 12,
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              child: new Container(
                width: 30.0,
                height: 30.0,
                child: new Icon(Icons.home,
                  color: Colors.white70,
                ),
              ),
            ),
            new Tab(
              child: new Container(
                width: 30.0,
                height: 30.0,
                child: new Icon(Icons.chat,
                  color: Colors.white70,
                ),
              ),
            ),
            new Tab(
              child: new Container(
                width: 30.0,
                height: 30.0,
                child: new Icon(Icons.account_box,
                color: Colors.white70,
                ),
              ),
            ),
          ],
          controller: controller,
        ),
      ),
          body: new TabBarView(
    children: <Widget>[new HomePage(), new Chat(), new Profile()],
    controller: controller,
    ),
    );
  }
}
