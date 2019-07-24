import 'package:flutter/material.dart';

class WhiteCardWidget extends StatelessWidget {
  Widget child;
  bool colored;
  WhiteCardWidget(this.child, {this.colored = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: child,
      ),
      elevation: 5,
      color: !colored ? Colors.white : Theme.of(context).primaryColor,
      margin: EdgeInsets.all(20),
      shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
    );
  }
}