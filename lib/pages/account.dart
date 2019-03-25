import 'package:flutter/material.dart';
//3.3.1
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}
//3.3.2
class _ProfileState extends State<Profile> {
  TabController controller;

  void initState() {
    super.initState();
  }
//3.3.2.1
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: new Text(
          "Konto", textAlign: TextAlign.center,
          style: new TextStyle(
              color: new Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
        ),
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        color: Theme.of(context).backgroundColor,
        width: screenSize.width,
        height: screenSize.height,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              height: 80.0,
              width: 80.0,
              decoration:
              new BoxDecoration(shape: BoxShape.circle),
            ),
            new Padding(
              padding: const EdgeInsets.all(12.0),
              child: new Text(
                "noget JSON",
                style: new TextStyle(
                  color: Color.fromRGBO(220, 28, 29, 1),
                    fontFamily: "Bebas",
                    fontSize: 20.0,
                    //fontWeight: FontWeight.bold,
                    letterSpacing: 0.8),
              ),
            ),
            new Text(
              "Igen JSON",
              style: new TextStyle(
                color: Color.fromRGBO(220, 28, 29, 1),
                  fontFamily: "Bebas",
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 0.7),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/acc_settings');
              },
              child: new Container(
                  width: 200.0,
                  height: 50.0,
                  margin: new EdgeInsets.only(top: 20.0),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                      borderRadius:
                      new BorderRadius.all(new Radius.circular(50.0))),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(
                        Icons.settings,
                        color: Color.fromRGBO(220, 28, 29, 1),
                      ),
                      new Text(
                        "Instillinger",
                        style: new TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 0.6,
                            color: Color.fromRGBO(220, 28, 29, 1),
                      ),
                      ),
                    ],
                  )),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/edit_profil');
              },
              child: new Container(
                  width: 200.0,
                  height: 50.0,
                  margin: new EdgeInsets.only(top: 24.0),
                  alignment: Alignment.center,
                  padding: new EdgeInsets.all(10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(
                        Icons.edit,
                        color: Color.fromRGBO(220, 28, 29, 1),
                      ),
                      new Text(
                        "Ret Profil",
                        style: new TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 0.6,
                            color: Color.fromRGBO(220, 28, 29, 1)
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
