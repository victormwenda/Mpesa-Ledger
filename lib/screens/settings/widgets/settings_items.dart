import 'package:flutter/material.dart';

class SettingsItems extends StatelessWidget {
  String title;

  SettingsItems(this.title);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        title: Text(title),
      ),
    );
  }
}
