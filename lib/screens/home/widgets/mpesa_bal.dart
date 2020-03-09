import 'package:flutter/material.dart';

class MpesaBalanceWidget extends StatelessWidget {
  final double mpesaBalance;

  MpesaBalanceWidget(this.mpesaBalance);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Latest account balance",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "KES " + mpesaBalance.toString(),
                style: Theme.of(context).textTheme.display4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
