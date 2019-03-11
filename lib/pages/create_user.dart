import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../utilities/alert.dart';


class CreateUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserState();
  }
}

class _CreateUserState extends State<CreateUserPage> {
  // Used to save data from submitform
  final Map<String, dynamic> _formData = {
    'firstname': null,
    'lastname': 'Test',
    'username': null,
    'password': null,
    //'image': 'assets/images/NoPicMale.png',
    //'gender': 4,
    //'bio': '',
    //'city': null,
    'roles': null
  };

  // Key used to point out whic form is being used
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Building widgets for the different TextFormFields
  // builds field for Name
  Widget _buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Fornavn', labelStyle: TextStyle(fontSize: 24)),
      validator: (String value) {
        if (value.isEmpty || value.trim().length < 2) {
          return 'Fornavn skal være på minimum 2 bogstaver.';
        }
      },
      onSaved: (String value) {
        _formData['firstname'] = value;
      },
    );
  }

  // Builds field for Email
  // Uses regular expression to check if it is a valid email
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
                  .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        },
        onSaved: (String value) {
          _formData['username'] = value;
        });
  }

  // Bields field for Password
  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Adganskode', labelStyle: TextStyle(fontSize: 24)),
      obscureText: true,
      validator: (String value) {
        if (value.length < 7) {
          return 'Adgangskode skal være på minimum 7 tegn.';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  // Builds field for Bio (or description, Bio is just shorter)
  Widget _buildBioTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Beskrivelse', labelStyle: TextStyle(fontSize: 24)),
      onSaved: (String value) {
        _formData['bio'] = value;
      },
    );
  }

  // Builds field for City
  Widget _buildCityTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'By',
        labelStyle: TextStyle(fontSize: 24),
      ),
      onSaved: (String value) {
        _formData['city'] = value;
      },
    );
  }

  // No more TextFields to create. Other widgets and functions follows

// Used to check if Password is correct
/*     Widget _buildPassRepeatTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Adganskode', labelStyle: TextStyle(fontSize: 24)),
      obscureText: true,
      validator: (String value) {
        if (value.length < 7) {
          return 'Adgangskode skal være på minimum 7 tegn.';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  } */

// Dropdown to insert gender
/*   Widget _buildGenderDropdownField() {
    final Map<String, int> _genders = {'Mand': 0, 'Kvinde': 1, 'Andet': 2};
    String dropdownValue = '';
    return DropdownButtonFormField<String>(
      value: dropdownValue,
      validator: (String value) {
        if (!_genders.containsValue(value)) {
          return 'Der er ikke valgt et køn';
        }
      },
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['', 'Mand', 'Kvinde', 'Andet']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onSaved: (String value) {
        _formData['gender'] = _genders[value];
      },
    );
  } */

  // Function to submit data if it is correct.
  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      // .validate runs through all validators
      print('NOT VALID');
      print(_formData);
      print('NOT VALID');
      return;
    }
    _formKey.currentState.save(); // Saves _formData if data is correct
    print('VALID');
    print(_formData);
    print('VALID');
    _createUser(_formData);
  }

  // Builds the submit button
  Widget _submitButton() {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 70.0),
      child: Text(
        'Opret',
        style: TextStyle(fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
      ),
      onPressed: _submitForm,
    );
  }

  void _createUser(Map<String, dynamic> user) {
    final Map<String, dynamic> newUser = {
      'firstName': user['firstname'],
      'lastName': 'Test from App',
      'username': user['username'],
      'password': user['password'],
    };

    var body = jsonEncode(newUser);
    Map<String, String> header = {
          "Accept": "application/json",
          "content-type": "application/json"
        };

    print(body);
    http.post('http://dateflix.captainanderz.com/api/users/register',
        body: body,
        headers: header
        ).then(
      (http.Response response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertText('Succes!', 'Bruger oprettet');
            },
          );
        } else {
          print(response.statusCode);
          print(response.body);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertText('Hovsa', 'Bruger ikke oprettet');
            },
          );
        }
      },
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              _buildNameTextField(),
              _buildEmailTextField(),
              _buildPasswordTextField(),
              //_buildGenderDropdownField(),
              _buildBioTextField(),
              _buildCityTextField(),
              _submitButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
