import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthPage> {
  final Map<String, String> _formData = {'email': null, 'password': null};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(fontSize: 24),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value.toLowerCase())) {
          return 'Please enter a valid email address';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(fontSize: 24),
      ),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty || value.length < 7) {
          return 'Passwords invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    final Map<String, dynamic> responseInfo =
        await authenticate(_formData['email'], _formData['password']);
    if (responseInfo['success']) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/loggedIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    return Material(
      color: Theme.of(context).backgroundColor,
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 25,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 65.0,
                    ),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 25.0, horizontal: 70.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Color.fromRGBO(220, 28, 39, 1)),
                                ),
                                onPressed: () =>
                                    _submitForm(model.authenticate),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
