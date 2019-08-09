import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/daily_transactions_cards.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/mpesa_bal.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Home extends StatefulWidget {
  ScrollController _scrollController = ScrollController();
  int limit = 5;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget._scrollController.addListener(_scrollController);
    homeBloc.getSMSDataEventSink.add(5);
    super.initState();
  }

  void _scrollController() {
    if (widget._scrollController.position.extentAfter == 0.0) {
      widget.limit += 5;
      homeBloc.getSMSDataEventSink.add(widget.limit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Home"),
        Expanded(
          child: StreamBuilder(
            stream: homeBloc.homeStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data["transactions"].length.toString());
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return DailyTransactions(
                      snapshot.data["transactions"][index - 1],
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
