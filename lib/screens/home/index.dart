import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/query_sms/query_sms_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/transactions/transactions_bloc.dart';
import 'package:mpesa_ledger_flutter/models/transaction_model.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/colored_card.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/white_card.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class Home extends StatefulWidget {
  TransactionBloc transactionBloc = TransactionBloc();
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
    var t = TextEditingController();

    return ListView(
      children: <Widget>[
        AppbarWidget("Home"),
        CarouselSlider(
          items: <Widget>[
            ColoredCardWidget(
              Text("Card 1")
            ),
            ColoredCardWidget(
              Text("Card 2")
            ),
            ColoredCardWidget(
              Text("Card 3")
            )
          ],
          onPageChanged: (int index) {
            print("changed to " + index.toString());
          },
          aspectRatio: 3,
          viewportFraction: 0.3,
        ),
        Text(
          "Headline 2345.00",
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          "Title",
          style: Theme.of(context).textTheme.title,
        ),
        Text(
          "Subhead",
          style: Theme.of(context).textTheme.subhead,
        ),
        Text(
          "This is the body",
          style: Theme.of(context).textTheme.body1,
        ),
        Text(
          "This is the caption",
          style: Theme.of(context).textTheme.caption,
        ),
        RaisedButtonWidget("BUTTON", () {}),
        FlatButtonWidget("BUTTON", () {}),
        TextFieldWidget("Label", t),
        TextFieldWidget("Label", t),
        Chip(
          label: Text("Chip"),
          // backgroundColor: Colors.black,
        ),
        ChipWidget("Chip 2"),
        WhiteCardWidget(
          Column(
            children: <Widget>[
              TextFieldWidget("Label", t),
              TextFieldWidget("Label", t),
            ],
          ),
        ),
        ColoredCardWidget(
          Column(
            children: <Widget>[
              TextFieldWidget("Label", t),
              TextFieldWidget("Label", t),
            ],
          ),
        )
      ],
    );
  }
}
