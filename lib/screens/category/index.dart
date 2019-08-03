import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:mpesa_ledger_flutter/blocs/categories/categories_bloc.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';

class Category extends StatefulWidget {
  CategoriesBloc _categoryBloc = CategoriesBloc();

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
            stream: widget._categoryBloc.categoriesStream,
            initialData: [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/categoryTransaction", arguments: {"id": snapshot.data[index]["id"], "title": snapshot.data[index]["title"]});
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
