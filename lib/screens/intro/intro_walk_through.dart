import 'package:flutter/material.dart';

class IntroWalkThrough extends StatefulWidget {
  @override
  _IntroWalkThroughState createState() => _IntroWalkThroughState();
}

class _IntroWalkThroughState extends State<IntroWalkThrough> {
  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(
      initialPage: 1,
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
    return Container(
      color: Colors.orange,
    );
  }
}

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}