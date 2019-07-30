import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/mpesa_bal.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/unknown_transaction_count_card.dart';

class HomeHeader extends StatelessWidget {

  Map<String, dynamic> headerData;

  HomeHeader(this.headerData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MpesaBalanceWidget(headerData["mpesaBalance"]),
            headerData["unknownTransactionCount"] > 0 ? UnknownTransactionCount(headerData["unknownTransactionCount"]) : Container()
          ],
        ),
      ),
    );
  }
}