import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackbarWidget {
  String message;
  Duration duration;
  bool isDismissible;
  VoidCallback onPressed;
  String buttonText;

  SnackbarWidget(this.message, {this.duration = const Duration(seconds: 3), this.onPressed, this.buttonText, this.isDismissible = true});

  Flushbar showSnackbar() {
    return Flushbar(
      message: message,
      duration: duration,
      isDismissible: false,
      mainButton: FlatButton(
        onPressed: onPressed,
        child: Text(buttonText),
        color: Colors.white,
      ),
    );
  }

}