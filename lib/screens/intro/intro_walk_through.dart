import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/appbar/appbar.dart';
import 'package:mpesa_ledger_flutter/widgets/intro_widgets/intro_widget.dart';

class IntroWalkThrough extends StatefulWidget {
  @override
  _IntroWalkThroughState createState() => _IntroWalkThroughState();
}

class _IntroWalkThroughState extends State<IntroWalkThrough> {
  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(
      initialPage: 0,
    );

    return PageView(
      controller: pageController,
      children: <Widget>[
        IntroPage1(),
        IntroPage2(),
        IntroPage3()
      ],
    );
  }
}

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Container(
        child: IntroWidget("This is intro 1", "This is where the desription will be displayed"),
      ),
    );
  }
}

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Container(
        child: IntroWidget("This is intro 2", "This is where the desription will be displayed"),
      ),
    );
  }
}

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: IntroWidget("This is intro 3", "This is where the desription will be displayed"),
      ),
    );
  }
}