import 'package:flutter/material.dart';

class ButtonStandard extends StatelessWidget {

  final Function() onPressed;
  final String labelText;

  ButtonStandard({this.onPressed, this.labelText});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        onPressed();
      },
      color: Colors.deepPurple[900],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          labelText,
          textScaleFactor: 1.2,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
