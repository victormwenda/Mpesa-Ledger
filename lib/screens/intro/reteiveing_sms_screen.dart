import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/app.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';

class RetreiveSMS extends StatefulWidget {
  QuerySMSBloc querySMSBloc = QuerySMSBloc();

  @override
  _RetreiveSMSState createState() => _RetreiveSMSState();
}

class _RetreiveSMSState extends State<RetreiveSMS> {
  @override
  void initState() {
    widget.querySMSBloc.retrieveSMSSink.add(null);
    super.initState();
  }

  @override
  void dispose() {
    counterPercentage.dispose();
    widget.querySMSBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.querySMSBloc.retrieveSMSCompleteStream.listen((data) {
      if (data) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (route) => App()),
        );
      }
    });

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
                    "Fetching MPESA messages",
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  child: StreamBuilder(
                    stream: counterPercentage.percentageProcessStream,
                    initialData: 0,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var percentageComplete =
                          snapshot.data >= 96 ? 100 : snapshot.data;
                      return Container(
                        child: Text(
                          percentageComplete.toString() + "%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 70.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Align(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
