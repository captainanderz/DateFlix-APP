import 'package:flutter/material.dart';

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        margin: EdgeInsets.all(50),
        child: Center(child: Text('You logged in')));
  }
}
