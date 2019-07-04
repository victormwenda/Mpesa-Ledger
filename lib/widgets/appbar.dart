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

enum PopupMenuButtonItems { settings, about }

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
      onSelected: (PopupMenuButtonItems item) {
        print(item);
        if (item == PopupMenuButtonItems.settings) {
          print("it is setting");
          Navigator.pushNamed(context, '/settings');
        } else if (item == PopupMenuButtonItems.about) {
          print("it is about");
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
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
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
