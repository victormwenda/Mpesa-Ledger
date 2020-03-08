import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChipWidget extends StatelessWidget {
  String label;
  VoidCallback onDelete;

  ChipWidget(this.label, {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDelete,
      deleteIcon: FaIcon(
        FontAwesomeIcons.times,
        size: 20.0,
        color: Theme.of(context).primaryColor,
      ),
      label: Text(label),
      backgroundColor: Theme.of(context).accentColor,
      labelStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontFamily: "Montserrat"),
    );
  }
}
