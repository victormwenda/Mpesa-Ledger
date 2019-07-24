import 'package:flutter/material.dart';

class ColoredCardWidget extends StatelessWidget {
  Widget child;
  ColoredCardWidget(this.child);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: child,
      ),
      color: Theme.of(context).primaryColor,
      elevation: 5,
      margin: EdgeInsets.all(20),
      shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
    );
  }
}