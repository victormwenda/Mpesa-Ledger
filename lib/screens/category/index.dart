import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mpesa_ledger_flutter/blocs/categories/categories_bloc.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/screens/category/widgets/category_chart.dart';
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
    categoriesBloc.getCategoriesEventSink.add(null);
    super.initState();
  }

  bool _deleteCategory(Map<String, dynamic> category) {
    bool delete = false;
    AlertDialogWidget(context,
        title: "Delete Category",
        content: Text(
          "Are you sure you want to delete " + category["title"],
        ),
        actions: [
          FlatButtonWidget("CANCEL", () {
            Navigator.of(context, rootNavigator: true).pop(context);
            delete = false;
          }),
          FlatButtonWidget("DELETE", () {
            categoriesBloc.deleteCategoryEventSink
                .add(category["id"].toString());
            Navigator.of(context, rootNavigator: true).pop(context);
            Flushbar(
              message: category["title"] + " successfully deleted",
              duration: Duration(seconds: 3),
            )..show(context);
            delete = true;
          }),
        ]).show();
    return delete;
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
            initialData: List<Map<String, dynamic>>(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return SizedBox(
                        height: 200.0,
                        child: CategoryChart(snapshot.data),
                      );
                    }
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Color(0XFFF44336),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.trash,
                                color: Colors.white,
                              ),
                              FaIcon(
                                FontAwesomeIcons.trash,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      confirmDismiss: (dire) {
                        if (snapshot.data[index - 1]["canDelete"] == 1) {
                          return Future.value(
                              _deleteCategory(snapshot.data[index - 1]));
                        } else {
                          Flushbar(
                            message: "You cannot delete default categories",
                            duration: Duration(seconds: 3),
                          )..show(context);
                          return Future.value(false);
                        }
                      },
                      child: InkWell(
                        splashColor: Theme.of(context).accentColor,
                        highlightColor: Theme.of(context).accentColor,
                        onTap: () {
                          Navigator.pushNamed(context, "/categoryTransaction",
                              arguments: CategoryModel.fromMap(
                                  snapshot.data[index - 1]));
                        },
                        child: ListTile(
                          title: Text(
                            snapshot.data[index - 1]["title"],
                            style: Theme.of(context).textTheme.title,
                          ),
                          subtitle: Text(snapshot.data[index - 1]
                                      ["numberOfTransactions"]
                                  .toString() +
                              " transactions"),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
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
