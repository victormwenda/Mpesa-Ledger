import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:mpesa_ledger_flutter/blocs/home/unknown_transactions_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/loading/loading_bloc.dart';
import 'package:mpesa_ledger_flutter/utils/date_format/date_format.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class UnknownTransactionsCard extends StatefulWidget {
  Map<String, dynamic> unknownTransaction;
  UnknownTransactionsBloc _unknownTransactionBloc = UnknownTransactionsBloc();

  LoadingBloc _loadingBloc = LoadingBloc();

  UnknownTransactionsCard(this.unknownTransaction);

  @override
  _UnknownTransactionsCardState createState() =>
      _UnknownTransactionsCardState();
}

class _UnknownTransactionsCardState extends State<UnknownTransactionsCard> {
  ReplaceUtil replaceUtil = ReplaceUtil();

  TextEditingController title = TextEditingController();

  var initialData = {"amount": 0.0, "selected": "None", "isDeposit": 0};

  _generateChoiceChips(List<double> listDouble) {
    List<Widget> chipLists = [];
    widget._unknownTransactionBloc.unknownTransactionMapEventSink
        .add(initialData);
    widget.unknownTransaction.addAll(initialData);
    chipLists.add(StreamBuilder(
        stream: widget._unknownTransactionBloc.unknownTransactionMapStream,
        initialData: initialData,
        builder: (context, snapshot) {
          return ChoiceChip(
            label: Text("None"),
            selected: snapshot.data["selected"] == "None",
            onSelected: (isSelected) {
              widget._unknownTransactionBloc.unknownTransactionMapEventSink
                  .add(initialData);
              widget.unknownTransaction.addAll(initialData);
            },
          );
        }));
    chipLists.add(SizedBox(width: 7));
    if (listDouble != null) {
      for (var i = 0; i < listDouble.length; i++) {
        chipLists.add(StreamBuilder(
            stream: widget._unknownTransactionBloc.unknownTransactionMapStream,
            initialData: initialData,
            builder: (context, snapshot) {
              return ChoiceChip(
                label: Text(listDouble[i].toString()),
                selected: snapshot.data["selected"] == listDouble[i].toString(),
                onSelected: (isSelected) {
                  widget._unknownTransactionBloc.unknownTransactionMapEventSink
                      .add({
                    "amount": listDouble[i],
                    "selected": listDouble[i].toString()
                  });
                  widget.unknownTransaction.addAll({
                    "amount": listDouble[i],
                    "selected": listDouble[i].toString()
                  });
                },
              );
            }));
        chipLists.add(SizedBox(width: 7));
      }
    }
    return chipLists;
  }

  _showDialog(context, transaction) {
    AlertDialogWidget(
      context,
      barrierDismissible: false,
      title: "Please confirm the transaction",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            transaction["title"],
          ),
          RichText(
            text: TextSpan(
              text: transaction["isDeposit"] == 1
                  ? "Deposit of "
                  : "Withdrawal of ",
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: transaction["amount"].toString(),
                  style: Theme.of(context).textTheme.body1.merge(
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: transaction["isDeposit"] == 1
                              ? Color(0XFF4CAF50)
                              : Color(0XFFF44336),
                        ),
                      ),
                )
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Transaction ID:  ",
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: transaction["transactionId"].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .merge(TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: "Date and Time:  ",
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: transaction["dateTime"].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .merge(TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: "Transaction Cost:  ",
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: "-KES " + transaction["transactionCost"].toString(),
                  style: Theme.of(context).textTheme.body1.merge(TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFFF44336))),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: "MPESA Balance:  ",
              style: Theme.of(context).textTheme.body1,
              children: [
                TextSpan(
                  text: "KES " + transaction["mpesaBalance"].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .merge(TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
        FlatButton(
          child: Text("CONFIRM"),
          onPressed: () {
            widget._unknownTransactionBloc.unknownTransactionInsertEventSink
                .add(transaction["id"]);
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      Column(
        children: <Widget>[
          CardWidget(
            Text(
              replaceUtil.replaceString(
                  widget.unknownTransaction["body"], "\\{.*\\}", ""),
              style: Theme.of(context).textTheme.body1.merge(TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor)),
            ),
            color: Theme.of(context).accentColor,
            margin: 0,
          ),
          SizedBox(
            height: 7,
          ),
          Divider(
            color: Colors.black54,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children:
                  _generateChoiceChips(widget.unknownTransaction["amounts"]),
            ),
          ),
          TextFieldWidget(
            "Title",
            title,
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream:
                  widget._unknownTransactionBloc.unknownTransactionMapStream,
              initialData: initialData,
              builder: (context, snapshot) {
                return RadioButtonGroup(
                  disabled: snapshot.data["selected"] == "None"
                      ? ["Deposited", "Withdrawn"]
                      : null,
                  activeColor: Theme.of(context).primaryColor,
                  labels: ["Deposited", "Withdrawn"],
                  onSelected: (item) {
                    widget
                        ._unknownTransactionBloc.unknownTransactionMapEventSink
                        .add({"isDeposit": item == "Deposited" ? 1 : 0});
                    widget.unknownTransaction
                        .addAll({"isDeposit": item == "Deposited" ? 1 : 0});
                  },
                );
              }),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<Object>(
              stream: widget._loadingBloc.loadingStream,
              initialData: false,
              builder: (context, snapshot) {
                return RaisedButtonWidget(
                  "CONFIRM",
                  () async {
                    if (title.text.isEmpty) {
                      Flushbar(
                        duration: Duration(seconds: 4),
                        isDismissible: false,
                        message: "Please add a title for this transaction",
                      )..show(context);
                    } else {
                      DateFormatUtil dateFormatUtil = DateFormatUtil();
                      var dateTime = await dateFormatUtil.getDateTime(
                          widget.unknownTransaction["timestamp"].toString());
                      widget.unknownTransaction.addAll(
                        {"title": title.text, "dateTime": dateTime["dateTime"]},
                      );
                      widget._unknownTransactionBloc
                          .unknownTransactionMapEventSink
                          .add(widget.unknownTransaction);

                      _showDialog(context, widget.unknownTransaction);
                      widget._unknownTransactionBloc.getUnknownTransactionEventSink.add(null);
                    }
                    // widget.unknownTransactionBloc.unknownTransactionEventSink.add(null);
                    // widget._loadingBloc.loadingSink.add(true);
                    // widget.unknownTransactionBloc.load(widget._loadingBloc.loadingSink);
                  },
                  loading: snapshot.data,
                );
              })
        ],
      ),
    );
  }
}
