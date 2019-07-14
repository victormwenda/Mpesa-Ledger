import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatefulWidget {
  String text;
  VoidCallback onPressed;
  bool loading;

  RaisedButtonWidget(this.text, this.onPressed, {this.loading = false});

  @override
  _RaisedButtonWidgetState createState() => _RaisedButtonWidgetState();
}

class _RaisedButtonWidgetState extends State<RaisedButtonWidget> {
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
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.deepPurpleAccent,
          offset: Offset(0, 7.0),
          spreadRadius: -5.0,
          blurRadius: 15.0,
        ),
      ]),
      child: RaisedButton(
        onPressed: widget.onPressed,
        padding: EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 20),
        child: showLoading(widget.loading),
        color: Colors.deepPurpleAccent[400],
        textColor: Colors.white,
        disabledElevation: 0,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
      ),
    );
  }
}
