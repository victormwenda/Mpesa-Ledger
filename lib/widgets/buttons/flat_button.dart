import 'package:flutter/material.dart';

class FlatButtonWidget extends StatefulWidget {
  String text;
  VoidCallback onPressed;
  bool loading;

  FlatButtonWidget(this.text, this.onPressed, {this.loading = false});

  @override
  _FlatButtonWidgetState createState() => _FlatButtonWidgetState();
}

class _FlatButtonWidgetState extends State<FlatButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Widget showLoading(bool loading) {
      if (loading) {
        return CircularProgressIndicator(
          backgroundColor: Colors.white,
        );
      }
      return Text(
        widget.text,
        style: TextStyle(fontWeight: FontWeight.w600),
      );
    }

    return Container(
      child: FlatButton(
        onPressed: widget.onPressed,
        padding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
        child: showLoading(widget.loading),
        textColor: Colors.white,
      ),
    );
  }
}
