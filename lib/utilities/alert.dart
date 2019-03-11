import 'package:flutter/material.dart';

class AlertText extends StatelessWidget {
  final String title;
  final String content;
  final String btnText;

  AlertText(this.title, this.content, [this.btnText]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          child: Text(btnText == null ? 'Ok' : btnText ),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
