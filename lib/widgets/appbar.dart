import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget {
  String title;
  bool showSearch;
  bool showAddCategory;

  AppbarWidget(this.title,
      {this.showSearch: true, this.showAddCategory: false});

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {

  List<Widget> showAppIcons(BuildContext context) {
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
        onPressed: () {},
      ));
    }

    appbarIcons.add(PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Text("Settings"),
          )
        ];
      },
    ));
    return appbarIcons;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: showAppIcons(context),
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<int> test = [1, 2, 3, 4, 5, 6, 7];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: Colors.black,
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListView.builder(
      itemCount: test.length,
      itemBuilder: (context, index) {
        return Text(test[index].toString());
      },
    );
  }
}
