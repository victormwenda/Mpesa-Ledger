import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/utils/date_format/date_format.dart';

class TransactionListItem extends StatefulWidget {
  Map<String, dynamic> transaction;

  TransactionListItem(this.transaction);

  @override
  _TransactionListItemState createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  DateFormatUtil _dateFormatUtil = DateFormatUtil();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                color: Colors.black45,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.transaction["title"],
                      style: Theme.of(context).textTheme.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.transaction["isDeposit"] == 1
                        ? "+KES " + widget.transaction["amount"].toString()
                        : "-KES " + widget.transaction["amount"].toString(),
                    style: Theme.of(context).textTheme.title.merge(
                          TextStyle(
                            fontSize: 16.5,
                            color: widget.transaction["isDeposit"] == 1
                                ? Color(0XFF4CAF50)
                                : Color(0XFFF44336),
                          ),
                        ),
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
          subtitle: widget.transaction["transactionId"] != null
              ? Text(widget.transaction["transactionId"])
              : Container(),
        ),
      ),
    );
  }
}
