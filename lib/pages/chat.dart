import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class Chat extends StatefulWidget {
final MainModel model;

Chat(this.model);

  @override
  _ChatState createState() => new _ChatState();
}

class _ChatState extends State<Chat> {
  TabController controller;

  void initState() {
    widget.model.fetchMatches();
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
         } else if (!model.isLoading && model.matches.length < 1) {
           return new Padding(
             padding: const EdgeInsets.all(12.0),
             child: new Text(
               "Der er ingen matches endnu",
               style: new TextStyle(
                   color: Colors.white70,
                   fontFamily: "Bebas",
                   fontSize: 15.0,
                   fontWeight: FontWeight.w100,
                   letterSpacing: 1.0),
             ),
           );
        } else {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: model.matches[index].hasPicture
                            ? NetworkImage(model.matches[index].picture[0])
                            : AssetImage('assets/images/noPic.png'),
                      ),
                      title: Text(model.matches[index].firstName),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                    Divider()
                  ],
                ),
              );
            },
            itemCount: model.matches.length,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: new Text(
          "Matches",
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: new Color.fromRGBO(220, 28, 39, 1), fontSize: 32.0),
        ),
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Theme.of(context).backgroundColor,
        child: _buildBody(context),
      ),
    );
  }
}
