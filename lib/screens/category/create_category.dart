import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class CreateCategory extends StatefulWidget {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController keyword = TextEditingController();

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          "New Category",
          showSearch: false,
          showPopupMenuButton: false,
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: prefix0.CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFieldWidget("Title", widget.title),
                    TextFieldWidget(
                      "Description",
                      widget.title,
                      keyboardType: TextInputType.multiline,
                      maxlines: 3,
                    ),
                    prefix0.SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Key Words",
                      style: prefix0.Theme.of(context).textTheme.caption,
                    ),
                    prefix0.Wrap(
                      children: <Widget>[
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                        ChipWidget("KCB"),
                      ],
                    ),
                    prefix0.SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        prefix0.Expanded(
                            child: TextFieldWidget("Keyword", widget.keyword)),
                        prefix0.SizedBox(
                          width: 10,
                        ),
                        RaisedButtonWidget("ADD", () {})
                      ],
                    ),
                    prefix0.SizedBox(
                      height: 20,
                    ),
                    prefix0.Center(
                      child: prefix0.Column(
                        children: <Widget>[
                          prefix0.Text(
                            "29",
                            style: prefix0.Theme.of(context).textTheme.display3.merge(
                              prefix0.TextStyle(
                                color: prefix0.Theme.of(context).primaryColor
                              )
                            ),
                          ),
                          prefix0.Text("messages found")
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
