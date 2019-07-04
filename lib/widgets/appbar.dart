import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget {

  String title;

  AppbarWidget(this.title);

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Text(widget.title, style: TextStyle(color: Colors.black),),
      centerTitle: true,
    );
  }
}