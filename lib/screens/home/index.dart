import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/counter/counter_bloc.dart';

import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/home/unrecorded_transaction_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/daily_transactions_cards.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/mpesa_bal.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Home extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  int limit = 5;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget._scrollController.addListener(_scrollController);
    homeBloc.getSMSDataEventSink.add(10);
    super.initState();
  }

  @override
  void dispose() {
    widget._scrollController.dispose();
    super.dispose();
  }

  void _scrollController() {
    if (widget._scrollController.position.extentAfter == 0.0) {
      widget.limit += 10;
      homeBloc.getSMSDataEventSink.add(widget.limit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<bool>(
            stream: unrecordedTransactionsBloc.showFetchEventStream,
            initialData: false,
            builder: (context, snapshot) {
              return StreamBuilder<int>(
                  stream: counter.counterStream,
                  initialData: 0,
                  builder: (context, snapshot2) {
                    var percentageComplete =
                        snapshot2.data >= 96 ? 100 : snapshot2.data;
                    return AppbarWidget(snapshot.data
                        ? "Fetching... $percentageComplete%"
                        : "Home");
                  });
            }),
        Expanded(
          child: StreamBuilder(
            stream: homeBloc.homeStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  controller: widget._scrollController,
                  itemCount: snapshot.data["transactions"].length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MpesaBalanceWidget(
                          snapshot.data["headerData"]["mpesaBalance"]);
                    }
                    if (index > snapshot.data["transactions"].length) {
                      return Center(
                        child: Container(),
                      );
                    }
                    return DailyTransactions(
                      snapshot.data["transactions"][index - 1],
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text("No MPESA transactions"),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
