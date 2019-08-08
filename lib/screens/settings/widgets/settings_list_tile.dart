import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  String title;
  VoidCallback onTap;

  SettingsListTile(this.title, this.onTap);

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
