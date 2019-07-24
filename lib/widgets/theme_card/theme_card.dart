import 'package:flutter/material.dart';

class ThemeCard extends StatelessWidget {
  Color color;

  ThemeCard(this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0)),
      child: SizedBox(
        width: 220,
      ),
    );
  }
}
