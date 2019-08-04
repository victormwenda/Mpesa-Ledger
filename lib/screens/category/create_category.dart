import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/blocs/categories/new_category_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/counter/counter_bloc.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class CreateCategory extends StatefulWidget {
  NewCategoryBloc _newCategoryBloc = NewCategoryBloc();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController keyword = TextEditingController();

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  List<Widget> _generateChips(List<String> listString) {
    List<Widget> chipList = [];
    for (var i = 0; i < listString.length; i++) {
      chipList.add(
        ChipWidget(
          listString[i],
          onDelete: () {
            widget._newCategoryBloc.deleteKeywordSink.add(i);
          },
        ),
      );
      chipList.add(prefix0.SizedBox(
        width: 10,
      ));
    }
    return chipList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          "New Category",
          showSearch: false,
          showPopupMenuButton: false,
          showAddNewCategory: true,
          addNewCategory: () {
            print("ok");
          },
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
                    StreamBuilder<List<String>>(
                        stream: widget._newCategoryBloc.keyWordChipStream,
                        initialData: [],
                        builder:
                            (context, AsyncSnapshot<List<String>> snapshot) {
                          return Wrap(
                            children: _generateChips(snapshot.data),
                          );
                        }),
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
                        RaisedButtonWidget(
                          "ADD",
                          () {
                            if (widget.keyword.text.isEmpty) {
                              Flushbar(
                                message: "Please add a keyword",
                                duration: Duration(seconds: 3),
                              )..show(context);
                            } else {
                              widget._newCategoryBloc.addKeywordSink
                                  .add(widget.keyword.text);
                              widget.keyword.clear();
                            }
                          },
                        )
                      ],
                    ),
                    prefix0.SizedBox(
                      height: 20,
                    ),
                    prefix0.Center(
                      child: prefix0.Column(
                        children: <Widget>[
                          StreamBuilder(
                            stream: counter.counterStream,
                            initialData: 0,
                            builder: (context, snapshot) {
                              return prefix0.Text(
                                snapshot.data.toString(),
                                style: prefix0.Theme.of(context)
                                    .textTheme
                                    .display3
                                    .merge(prefix0.TextStyle(
                                        color: prefix0.Theme.of(context)
                                            .primaryColor)),
                              );
                            }
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
