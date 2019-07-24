import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  String label;
  TextInputType keyboardType;
  TextEditingController textFieldController;
  bool autoFocus;

  TextFieldWidget(this.label, this.textFieldController, {this.keyboardType = TextInputType.text, this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        controller: textFieldController,
        autofocus: autoFocus,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: false,
          labelText: label,
          contentPadding: EdgeInsets.all(17.0),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
