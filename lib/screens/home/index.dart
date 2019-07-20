import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/transactions/transactions_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Home extends StatefulWidget {
  QuerySMS bloc = QuerySMS();
  TransactionBloc transactionBloc = TransactionBloc();
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
    widget.bloc.retrieveSMSMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Home"),
        StreamBuilder<List<TransactionModel>>(
          stream: widget.transactionBloc.transactionControllerStream,
          initialData: [],
          builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          title: Text(snapshot.data[index].title.toString()),
                          leading: Text("KES "+snapshot.data[index].amount.toString()),
                        ),
                      ),
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
