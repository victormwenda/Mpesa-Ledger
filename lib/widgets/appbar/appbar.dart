import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mpesa_ledger_flutter/blocs/search/search_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/widgets/generate_transactions.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class AppbarWidget extends StatefulWidget {
  String title;
  bool showSearch;
  bool showAddCategory;
  bool showPopupMenuButton;
  bool showAddNewCategory;
  bool showBackButton;
  VoidCallback addNewCategory;

  AppbarWidget(this.title,
      {this.showSearch: true,
      this.showPopupMenuButton: true,
      this.showAddCategory: false,
      this.showAddNewCategory: false,
      this.addNewCategory, this.showBackButton: false});

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  List<Widget> _showAppIcons(BuildContext context) {
    List<Widget> appbarIcons = [];
    if (widget.showSearch) {
      appbarIcons.add(IconButton(
        icon: FaIcon(FontAwesomeIcons.search),
        color: Colors.black,
        iconSize: 20,
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
      ));
    }
    if (widget.showAddCategory) {
      appbarIcons.add(IconButton(
        icon: FaIcon(FontAwesomeIcons.plus),
        iconSize: 20,
        color: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, '/createCategory');
        },
      ));
    }
    if (widget.showAddNewCategory) {
      appbarIcons.add(IconButton(
        icon: FaIcon(FontAwesomeIcons.check),
        color: Colors.black,
        iconSize: 20,
        onPressed: widget.addNewCategory,
      ));
    }
    if (widget.showPopupMenuButton) {
      appbarIcons.add(PopupMenuButton(
        icon: FaIcon(
          FontAwesomeIcons.ellipsisV,
          color: Colors.black,
          size: 20,
        ),
        onSelected: (PopupMenuButtonItems item) {
          if (item == PopupMenuButtonItems.settings) {
            Navigator.pushNamed(context, '/settings');
          }
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: PopupMenuButtonItems.settings,
              child: Text("Settings"),
            ),
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
        color: widget.showBackButton ? Colors.black : Colors.white,
      ),
      actions: _showAppIcons(context),
      backgroundColor: Colors.white10,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.title,
      ),
      centerTitle: true,
      elevation: 0.0,
    );
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
        icon: FaIcon(FontAwesomeIcons.times),
        color: Colors.black,
        iconSize: 20,
        onPressed: () {
          query = "";
          searchBloc.searchSink.add([]);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: FaIcon(FontAwesomeIcons.arrowLeft),
      color: Colors.black,
      iconSize: 20,
      onPressed: () {
        close(context, query);
      },
    );
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
