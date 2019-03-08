import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Image.asset('assets/images/dateflix.png'),
            SizedBox(height: 50,),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 70.0),
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 28, color: Color.fromARGB(255,220,39,28),)
              ),
              onPressed: () {
                print('Login pressed');
                Navigator.pushNamed(context, '/auth');
              },
            ),
            SizedBox(
              height: 55.0,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 18),
              child: Text(
                'Opret ny bruger',
                style: TextStyle(
                    fontSize: 28, color: Color.fromRGBO(220, 28, 39, 1)),
              ),
              onPressed: () {
                print('Opret ny bruger pressed');
              },
            )
          ],
        ),
      ),
      color: Theme.of(context).backgroundColor,
    );
  }
}
