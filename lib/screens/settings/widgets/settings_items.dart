import 'package:flutter/material.dart';

class SettingsItems extends StatelessWidget {
  String title;
  VoidCallback onTap;

  SettingsItems(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
      ),
    );
  }
}
