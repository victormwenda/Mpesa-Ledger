import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/bloc.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar.dart';

class Home extends StatefulWidget {
  var bloc = QuerySMS();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.bloc.getAllSMSMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Home"),
        StreamBuilder<List>(
          stream: widget.bloc.readSMSStream,
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(snapshot.data[index]["body"]),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
