import 'package:flutter/material.dart';

class TextFieldBase extends StatelessWidget {
  
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final void Function() onChangedCallback;
  
  TextFieldBase({this.controller, this.keyboardType, this.textInputAction, this.labelText, this.onChangedCallback});
  
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: textStyle,
        onChanged: (text) {
          onChangedCallback();
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}
