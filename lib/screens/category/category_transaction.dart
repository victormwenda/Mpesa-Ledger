import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/blocs/categories/categories_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/screens/category/widgets/category_transaction_header.dart';
import 'package:mpesa_ledger_flutter/screens/category/widgets/transaction_list_item.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class CategoryTransaction extends StatefulWidget {

  CategoryModel categoryModel;

  CategoryTransaction(this.categoryModel);

  @override
  _CategoryTransactionState createState() => _CategoryTransactionState();
}

class _CategoryTransactionState extends State<CategoryTransaction> {

  @override
  void initState() {
    categoriesBloc.getTransactionsSink.add(widget.categoryModel.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          widget.categoryModel.title,
          showSearch: false,
          showPopupMenuButton: false,
        ),
        Expanded(
          child: StreamBuilder(
            stream: categoriesBloc.transactionsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data["transactions"].length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return CategoryTransactionHeader(snapshot.data["totals"], widget.categoryModel);
                    }
                    return TransactionListItem(snapshot.data["transactions"][index - 1]);
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
