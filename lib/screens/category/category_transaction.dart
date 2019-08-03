import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/categories/categories_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/category/widgets/category_transaction_header.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class CategoryTransaction extends StatefulWidget {
  CategoriesBloc _categoryBloc = CategoriesBloc();

  Map<dynamic, dynamic> map;

  CategoryTransaction(this.map);

  @override
  _CategoryTransactionState createState() => _CategoryTransactionState();
}

class _CategoryTransactionState extends State<CategoryTransaction> {

  @override
  void initState() {
    widget._categoryBloc.getTransactionsSink.add(widget.map["id"].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          widget.map["title"],
          showSearch: false,
          showPopupMenuButton: false,
        ),
        Expanded(
          child: StreamBuilder(
            stream: widget._categoryBloc.transactionsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data["transactions"].length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return CategoryTransactionHeader(snapshot.data["totals"]);
                    }
                    return Text(snapshot.data["transactions"][index -1].toString());
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
