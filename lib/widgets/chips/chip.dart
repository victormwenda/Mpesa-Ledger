import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {

  String label;

  ChipWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).accentColor,
      labelStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Montserrat"
      ),
    );
  }
}