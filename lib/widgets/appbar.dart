import 'package:flutter/material.dart';

class AppbarWidget extends StatefulWidget {
  String title;

  AppbarWidget(this.title);

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          },
        )
      ],
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
