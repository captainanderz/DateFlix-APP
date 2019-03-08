import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserState();
  }
}

class _CreateUserState extends State<CreateUserPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
    'password': null,
    'image': 'assets/images/NoPicMale.png',
    'Gender': null,
    'Bio': null,
    'City': null,
    'CreatedDate': null,
  };

  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Brugernavn',
        labelStyle: TextStyle(fontSize: 24)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Theme.of(context).backgroundColor,
      child: ListView(
        children: <Widget>[],
      ),
    );
  }
}
