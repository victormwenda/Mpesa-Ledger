import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/walk_through/walk_through.dart';

void main() => runApp(WalkThrough());

class WalkThrough extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        IntroPage1(),
        IntroPage2(),
        IntroPage3(),
        IntroPage4(),
      ],
    );
  }
}
 
class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroWidget("Oraganized MPESA messages", "View your MPESA messages in clean and organized way", "assets/images/holding_phone_colour.svg"),
      ),
    );
  }
}

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroWidget("Categorize your MPESA messages", "You can categorize your MPESA messages into groups", "assets/images/holding_phone_colour.svg"),
      ),
    );
  }
}

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroWidget("Summary of your MPESA transactions", "Get analytical view of all your MPESA transactions monthly and yearly", "assets/images/holding_phone_colour.svg"),
      ),
    );
  }
}

class IntroPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroWidget("All of your MPESA messages secured", "Your MPESA messages are secured in your phone", "assets/images/holding_phone_colour.svg"),
      ),
    );
  }
}
