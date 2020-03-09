import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/base_bloc.dart';
import 'package:mpesa_ledger_flutter/widgets/walk_through/walk_through.dart';

class WalkThroughBloc extends BaseBloc {

  final List<Widget> walkThroughPagesList = <Widget>[
    WalkThroughPage1(),
    WalkThroughPage2(),
    WalkThroughPage3(),
    WalkThroughPage4(),
  ];

  StreamController<List<Widget>> _walkThroughController =
      StreamController<List<Widget>>();
  Stream<List<Widget>> get walkThroughControllerStream =>
      _walkThroughController.stream;
  StreamSink<List<Widget>> get walkThroughControllerSink =>
      _walkThroughController.sink;

  // EVENTS

  StreamController<int> _changePageEventController = StreamController<int>();
  Stream<int> get changePageEventStream => _changePageEventController.stream;
  StreamSink<int> get changePageEventSink => _changePageEventController.sink;

  void initializeWalkThrough() {
    print("walk through initialized");
    walkThroughControllerSink.add(walkThroughPagesList);
  }

  @override
  void dispose() {
    _walkThroughController.close();
    _changePageEventController.close();
  }
  
}

class WalkThroughPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WalkThroughWidget(
            "Oraganized MPESA messages",
            "View your MPESA messages in a clean and organized way",
            "assets/images/drawkit-list-app-colour.svg"),
      ),
    );
  }
}

class WalkThroughPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WalkThroughWidget(
            "Categorize your MPESA messages",
            "You can categorize your MPESA messages into groups",
            "assets/images/drawkit-folder-woman-colour.svg"),
      ),
    );
  }
}

class WalkThroughPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WalkThroughWidget(
            "Summary of your MPESA transactions",
            "Get analytical view of all your MPESA transactions by month and year",
            "assets/images/drawkit-charts-and-graphs.svg"),
      ),
    );
  }
}

class WalkThroughPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WalkThroughWidget(
            "All of your MPESA messages secured",
            "Your MPESA messages are securely stored in your phone",
            "assets/images/unlock.svg"),
      ),
    );
  }
}