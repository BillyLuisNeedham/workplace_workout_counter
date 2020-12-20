import 'package:flutter/material.dart';

import '../strings.dart';

// TODO write

class TextFieldStandard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: TextField(
        // TODO update controller: repsController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        style: textStyle,
        onChanged: (text) {
          updateReps();
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: Strings.minutesPerRep),
      ),
    ),
  }
}
