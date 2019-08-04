import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {

  String label;
  VoidCallback onDelete;

  ChipWidget(this.label, {this.onDelete = null});

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDelete,
      deleteIcon: Icon(Icons.cancel),
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