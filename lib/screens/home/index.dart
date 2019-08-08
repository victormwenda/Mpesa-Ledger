import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/daily_transactions_cards.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/mpesa_bal.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.getSMSDataEventSink.add(null);
    super.initState();
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
                return ListView.builder(
                  itemCount: snapshot.data["transactions"].length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MpesaBalanceWidget(snapshot.data["headerData"]["mpesaBalance"]);
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
