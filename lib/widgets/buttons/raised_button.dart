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
      );
    }

    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).accentColor,
          offset: Offset(0, 7.0),
          spreadRadius: -5.0,
          blurRadius: 15.0,
        ),
      ]),
      child: RaisedButton(
        onPressed: widget.onPressed,
        child: showLoading(widget.loading),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
      ),
    );
  }
}
