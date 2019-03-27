import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utilities/bday.dart';
import '../scoped_models/main.dart';
import '../utilities/alert.dart';


// 3.5.1
class CreateUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateUserState();
  }
}

// 3.5.2
class _CreateUserState extends State<CreateUserPage> {
  // Used to save data from submitform
  final Map<String, dynamic> _formData = {
    'firstname': null,
    'lastname': 'Test',
    'username': null,
    'password': null,
    'year': null,
    'month': null,
    'day': null,
    'image': 'assets/images/NoPicMale.png',
    'gender': 4,
    'bio': '',
    'city': null,
    'roles': null
  };

  // Key used to point out which form is being used
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController used confirm password
  final TextEditingController _passwordController = TextEditingController();

  // 3.5.2.1
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

  // 3.5.2.2
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
          _formData['email'] = value;
        });
  }

  // 3.5.2.3
  // Bields field for Password
  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Adganskode', labelStyle: TextStyle(fontSize: 24)),
      obscureText: true,
      controller: _passwordController,
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

  // 3.5.2.4
  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Bekræft adganskode', labelStyle: TextStyle(fontSize: 24)),
      obscureText: true,
      validator: (String value) {
        if (value != _passwordController.text) {
          return 'Adgangskoden stemmer ikke overens';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  // 3.5.2.5
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

  // 3.5.2.6
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

// 3.5.2.7
Widget _buildRadioButton(int value, String title)
{
  return RadioListTile<int>(
          activeColor: Color.fromRGBO(220, 28, 39, 1),
          title: Text(title),
          value: value,
          groupValue: _formData['gender'],
          onChanged: (int value) {
            setState(() {
              _formData['gender'] = value;
            });
          },
        );
}

// 3.5.2.8
// Radio buttons to select gender
  Widget _buildGenderRadioGroup() {
    return GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      shrinkWrap: true,
      children: <Widget>[
        _buildRadioButton(0, 'Mand'),
        _buildRadioButton(1, 'Kvinde'),
        _buildRadioButton(2, 'Andet')
      ],
    );
  }

  // 3.5.2.9  
  bool ageCheck(String year) {
    DateTime current = DateTime.now();
    return current.year - int.parse(year) >= 18;
  }

  // 3.5.2.10
  Widget _buildYearField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'År',
        labelStyle: TextStyle(fontSize: 24),
      ),
      validator: (String value) {
        if (!ageCheck(value)) {
          return 'Alle brugere skal være minimum 18 år';
        }
      },
      onSaved: (String value) {
        _formData['year'] = value;
      },
    );
  }

  // 3.5.2.11
  Widget _buildMonthField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Måned',
        labelStyle: TextStyle(fontSize: 24),
      ),
      validator: (String value) {
        if (int.parse(value) < 1 || int.parse(value) > 12) {
          return 'Månederne går fra 1 til 12';
        }
      },
      onSaved: (String value) {
        _formData['month'] = value;
      },
    );
  }

  // 3.5.2.12
  Widget _buildDayField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Dag',
        labelStyle: TextStyle(fontSize: 24),
      ),
      validator: (String value) {
        if (int.parse(value) < 1 || int.parse(value) > 31) {
          return 'Fejl i dag';
        }
      },
      onSaved: (String value) {
        _formData['day'] = value;
      },
    );
  }

  // 3.5.2.13
  Widget _buildBdayGrid() {
    return GridView(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      shrinkWrap: true,
      children: <Widget>[
        _buildDayField(),
        _buildMonthField(),
        _buildYearField()
      ],
    );
  }

  // 3.2.2.14
  bool validDate(String year, String month, String day) {
    DateTime bday = DateTime(int.parse(year), int.parse(month), int.parse(day));
    if (bdayToAge(bday) >= 18) {
      return true;
    }
    return false;
  }

  // 3.5.2.15
  // Function to submit data.
  void _submitForm(Function createUser, Function authenticate) async {
    if (!_formKey.currentState.validate()) {
      // .validate runs through all validators
      return;
    }
    _formKey.currentState.save(); // Saves _formData if data is correct
    final Map<String, dynamic> responseInfo = await createUser(_formData);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertText(responseInfo['title'].toString(),
              responseInfo['message'].toString());
        });
    if (responseInfo['title'].toString() == 'Success!') {
      Map<String, dynamic> loginInfo =
          await authenticate(_formData['email'], _formData['password']);
      if (loginInfo['success']) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/acc_settings_first');
      }
    }
  }

  // 3.5.2.16
  // Builds the submit button
  Widget _submitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 70.0),
                child: Text(
                  'Opret',
                  style: TextStyle(
                      fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
                ),
                onPressed: () =>
                    _submitForm(model.createUser, model.authenticate),
              );
      },
    );
  }

  // 3.5.2.17
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
              _buildPasswordConfirmTextField(),
              _buildBdayGrid(),
              _buildGenderRadioGroup(),
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
