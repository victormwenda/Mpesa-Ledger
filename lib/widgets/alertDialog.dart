import 'package:flutter/material.dart';

class AlertDialogWidget {
  String title;
  BuildContext context;
  Widget content;
  List<Widget> actions;
  bool barrierDismissible;

  AlertDialogWidget(this.context,
      {@required this.title, @required this.content, @required this.actions, this.barrierDismissible: true});

  show() {
    return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: content,
          actions: actions,
        );
      },
    );
  }
}