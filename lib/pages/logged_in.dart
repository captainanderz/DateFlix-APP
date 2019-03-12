import 'package:flutter/material.dart';

class LoggedInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(brightness: Brightness.dark,
        title: Text('Dateflix', style: TextStyle(color: Colors.white70),),
        leading: Icon(Icons.menu, color: Colors.white70,),
        backgroundColor: Color.fromRGBO(38, 35, 35, 1),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}