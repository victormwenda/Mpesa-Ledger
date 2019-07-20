import 'package:flutter/material.dart';

class RetreiveSMS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Fetching all MPESA sms messages",
                    style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  child: Text(
                    "100%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 70.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                    child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
