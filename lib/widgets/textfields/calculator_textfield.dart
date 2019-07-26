import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorTextFieldWidget extends StatelessWidget {
  TextEditingController textFieldController;

  CalculatorTextFieldWidget(this.textFieldController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        style: Theme.of(context).textTheme.display3,
        controller: textFieldController,
        autofocus: true,
        maxLength: 5,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: false,
        ),
      ),
    );
  }
}
