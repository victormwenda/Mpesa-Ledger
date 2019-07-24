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
      );
    }

    return Container(
      child: FlatButton(
        onPressed: widget.onPressed,
        child: showLoading(widget.loading),
        textColor: Theme.of(context).primaryColor,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
      ),
    );
  }
}
