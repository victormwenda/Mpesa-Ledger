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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (route) => App()),
          (Route<dynamic> route) => false
        );
      }
    });

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                child: Text(
                  "Fetching MPESA messages",
                  style: Theme.of(context).textTheme.display3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
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
            flex: 1,
            child: Align(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
