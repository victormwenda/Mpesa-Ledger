import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/firebase/firebase_auth_bloc.dart';
import 'package:mpesa_ledger_flutter/blocs/search/search_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/generate_transactions.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class AppbarWidget extends StatefulWidget {
  String title;
  bool showSearch;
  bool showAddCategory;
  bool showPopupMenuButton;
  bool showAddNewCategory;
  VoidCallback addNewCategory;

  FirebaseAuthBloc _firebaseAuthBloc = FirebaseAuthBloc();

  AppbarWidget(this.title,
      {this.showSearch: true,
      this.showPopupMenuButton: true,
      this.showAddCategory: false,
      this.showAddNewCategory: false,
      this.addNewCategory});

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  List<Widget> _showAppIcons(BuildContext context) {
    List<Widget> appbarIcons = [];
    if (widget.showSearch) {
      appbarIcons.add(IconButton(
        icon: Icon(Icons.search),
        color: Colors.black,
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
      ));
    }
    if (widget.showAddCategory) {
      appbarIcons.add(IconButton(
        icon: Icon(Icons.add),
        color: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/createCategory');
        },
      ));
    }
    if (widget.showAddNewCategory) {
      appbarIcons.add(IconButton(
        icon: Icon(Icons.done),
        color: Colors.black,
        onPressed: widget.addNewCategory,
      ));
    }
    if (widget.showPopupMenuButton) {
      appbarIcons.add(PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        onSelected: (PopupMenuButtonItems item) {
          if (item == PopupMenuButtonItems.settings) {
            Navigator.pushNamed(context, '/settings');
          } else if (item == PopupMenuButtonItems.about) {
            Navigator.pushNamed(context, '/about');
          } else if (item == PopupMenuButtonItems.signOut) {
            widget._firebaseAuthBloc.signOutEventSink.add(null);
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: PopupMenuButtonItems.settings,
              child: Text("Settings"),
            ),
            PopupMenuItem(
              value: PopupMenuButtonItems.about,
              child: Text("About"),
            ),
            PopupMenuItem(
              value: PopupMenuButtonItems.signOut,
              child: Text("Sign Out"),
            )
          ];
        },
      ));
    }
    return appbarIcons;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: _showAppIcons(context),
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.title,
      ),
      centerTitle: true,
    );
  }

  @override
  void dispose() { 
    widget._firebaseAuthBloc.dispose();
    super.dispose();
  }
}

class DataSearch extends SearchDelegate<String> {
  Widget _generateSearchResults(context) {
    closeSearch() {
      close(context, query);
    }
    searchBloc.searchEventSink.add(query);
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: searchBloc.searchStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: GenerateTransactions().generateTransactions(context,
                      snapshot.data[index]["transactions"], closeSearch),
                ),
              );
            },
          );
        }
        return Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Center(child: CircularProgressIndicator()),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            )
          ],
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: Colors.black,
        onPressed: () {
          query = "";
          searchBloc.searchSink.add([]);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return _generateSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _generateSearchResults(context);
  }
}
