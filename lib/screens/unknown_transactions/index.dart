import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/home/unknown_transactions_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/unknown_transactions/widgets/unknown_transactions_card.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class UnknownTransactions extends StatefulWidget {

  UnknownTransactionsBloc _unknownTransactionBloc = UnknownTransactionsBloc();

  @override
  _UnknownTransactionsState createState() => _UnknownTransactionsState();
}

class _UnknownTransactionsState extends State<UnknownTransactions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          "Unknown Transactions",
          showSearch: false,
          showPopupMenuButton: false,
        ),
        Expanded(
          child: StreamBuilder(
            stream: widget._unknownTransactionBloc.unknownTransactionStream,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                return UnknownTransactionsCard(snapshot.data[index]);
               },
              );
            },
          ),
        )
      ],
    );
  }
}
