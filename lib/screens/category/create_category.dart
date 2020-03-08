import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/categories/new_category_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/counter/counter_bloc.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class CreateCategory extends StatefulWidget {
  final NewCategoryBloc _newCategoryBloc = NewCategoryBloc();

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController keyword = TextEditingController();

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
            widget._newCategoryBloc.deleteKeywordEventSink.add(i);
          },
        ),
      );
      chipList.add(SizedBox(
        width: 10,
      ));
    }
    return chipList;
  }

  @override
  void dispose() {
    widget._newCategoryBloc.dispose();
    super.dispose();
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
          showBackButton: true,
          addNewCategory: () {
            if (widget.title.text.isEmpty && widget.description.text.isEmpty) {
              Flushbar(
                message: "Please add a title and a description",
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              widget._newCategoryBloc.addCategoryEventSink.add({
                "context": context,
                "title": widget.title.text,
                "description": widget.description.text
              });
            }
          },
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFieldWidget("Title", widget.title),
                    TextFieldWidget(
                      "Description",
                      widget.description,
                      keyboardType: TextInputType.multiline,
                      maxlines: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          StreamBuilder(
                            stream: counter.counterStream,
                            initialData: 0,
                            builder: (context, snapshot) {
                              return Text(
                                snapshot.data.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .display3
                                    .merge(
                                      TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                              );
                            },
                          ),
                          Text("messages found")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Keywords",
                      style: Theme.of(context).textTheme.caption,
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget("Keyword", widget.keyword),
                    Center(
                      child: RaisedButtonWidget(
                        "ADD KEYWORD",
                        () {
                          if (widget.keyword.text.isEmpty) {
                            Flushbar(
                              message: "Please add a keyword",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          } else {
                            widget._newCategoryBloc.addKeywordEventSink
                                .add(widget.keyword.text);
                            widget.keyword.clear();
                          }
                        },
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
