import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/blocs/categories/categories_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/dialogs/alertDialog.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    categoriesBloc.getCategoriesSink.add(null);
    super.initState();
  }

  _deleteCategory(Map<String, dynamic> category) {
    AlertDialogWidget(context,
        title: "Delete Category",
        content: prefix0.Text("Are you sure you want to delete " + category["title"]),
        actions: [
          FlatButtonWidget(
            "CANCEL",
            () {
              Navigator.of(context, rootNavigator: true).pop(context);
            }
          ),
          FlatButtonWidget(
            "DELETE",
            () {
              categoriesBloc.deleteCategorySink.add(category["id"].toString());
              Navigator.of(context, rootNavigator: true).pop(context);
              Flushbar(
                message: category["title"] + " successfully deleted",
                duration: Duration(seconds: 3),
              )..show(context);
            }
          ),
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppbarWidget(
          "Category",
          showAddCategory: true,
          showSearch: false,
        ),
        Expanded(
          child: StreamBuilder(
            stream: categoriesBloc.categoriesStream,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onLongPress: () {
                        if(snapshot.data[index]["canDelete"] == 1) {
                          _deleteCategory(snapshot.data[index]);
                        } else {
                          Flushbar(
                            message: "You cannot delete default categories",
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      },
                      onTap: () {
                        Navigator.pushNamed(context, "/categoryTransaction",
                            arguments: CategoryModel.fromMap(snapshot.data[index]));
                      },
                      child: ListTile(
                        title: Text(
                          snapshot.data[index]["title"],
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(snapshot.data[index]
                                    ["numberOfTransactions"]
                                .toString() +
                            " transactions"),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}
