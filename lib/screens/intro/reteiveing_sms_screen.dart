import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mpesa_ledger_flutter/app.dart';
import 'package:mpesa_ledger_flutter/blocs/counter/counter_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';

class RetreiveSMS extends StatefulWidget {
  final QuerySMSBloc querySMSBloc = QuerySMSBloc();

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
    widget.querySMSBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.querySMSBloc.retrieveSMSCompleteStream.listen((data) async {
      if (data) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (route) => App()),
            (Route<dynamic> route) => false);
      } else {
        Flushbar(
          isDismissible: false,
          message:
              "An error occured while fetching SMS messages, app will be closed in 5 seconds, please reopen again",
        )..show(context);
        await Future.delayed(Duration(seconds: 7));
        SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
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
                stream: counter.counterStream,
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
