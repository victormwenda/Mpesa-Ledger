import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  Widget child;
  Color color;
  double padding;
  double margin;
  CardWidget(this.child, {this.color = Colors.white, this.padding: 20, this.margin: 10});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
      elevation: 5,
      color: color,
      margin: EdgeInsets.all(margin),
      shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
    );
  }
}