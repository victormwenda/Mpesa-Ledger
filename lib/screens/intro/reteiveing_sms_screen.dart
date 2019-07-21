import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';
import 'package:mpesa_ledger_flutter/database/databaseProvider.dart';
import 'package:mpesa_ledger_flutter/sms_filter/index.dart';

class RetreiveSMS extends StatefulWidget {
  @override
  _RetreiveSMSState createState() => _RetreiveSMSState();
}

class _RetreiveSMSState extends State<RetreiveSMS> {
  @override
  void initState() {
    super.initState();
  }

  static String forloop(int s) {
    for (var i = 0; i < 1000000000; i++) {}
    return "done";
  }

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
                    "Fetching all ",
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
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
                child: Align(child: CircularProgressIndicator()),
              ),
              RaisedButton(
                onPressed: () async {
                  // print(forloop());
                  QuerySMSBloc bloc = QuerySMSBloc();
                  bloc.retrieveSMSSink.add(null);

                  // DatabaseProvider databaseProvider = DatabaseProvider();
                  // databaseProvider.deleteDatabaseMeth();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
