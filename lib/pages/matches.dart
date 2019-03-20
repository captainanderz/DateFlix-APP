import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class MatchesListPage extends StatefulWidget {
  final MainModel model;

  MatchesListPage(this.model);
  @override
  State<StatefulWidget> createState() {
    return _MatchesListPageState();
  }
}

class _MatchesListPageState extends State<MatchesListPage> {
  @override
  void initState() {
    widget.model.fetchMatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
              );
      },
    );
  }
}
