import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/home/home_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/daily_transactions.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/home_header.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/mpesa_bal.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Home extends StatefulWidget {
  HomeBloc _homeBloc = HomeBloc();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget("Home"),
        Expanded(
          child: StreamBuilder(
            stream: widget._homeBloc.homeStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data["transactions"].length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return HomeHeader(snapshot.data["headerData"]);
                    }
                    return DailyTransactions(
                        snapshot.data["transactions"][index - 1]);
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
