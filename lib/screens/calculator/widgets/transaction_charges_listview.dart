import 'package:flutter/material.dart';

class TransactionChargesList extends StatelessWidget {

  Map<String, String> transactionCharges;

  TransactionChargesList(this.transactionCharges);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Send to Mpesa User",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    transactionCharges["transferToMpesaUsers"],
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Send to Other Mobile User",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    transactionCharges["transferToOtherUsers"],
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Send to Unregistered Mpesa User",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    transactionCharges["transferToUnregisteredUsers"],
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Withdraw From Agent",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    transactionCharges["withdrawFromAgent"],
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  "Withdraw From ATM",
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    transactionCharges["atmWithdrawal"],
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
