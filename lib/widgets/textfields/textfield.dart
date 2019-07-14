import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  String label;
  TextInputType keyboardType;
  TextEditingController textFieldController;
  bool autoFocus;

  TextFieldWidget(this.label, this.textFieldController, {this.keyboardType = TextInputType.text, this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: false,
        labelText: label,
        contentPadding: EdgeInsets.all(20.0),
        border: OutlineInputBorder(),
      ),
    );
  }
}
