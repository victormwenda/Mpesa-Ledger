import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:mpesa_ledger_flutter/widgets/theme_card/theme_card.dart';

class ChooseTheme extends StatefulWidget {
  @override
  _ChooseThemeState createState() => _ChooseThemeState();
}

class _ChooseThemeState extends State<ChooseTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                child: Text(
                  "Choose a favourite theme",
                  style: Theme.of(context).textTheme.display3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              child: CarouselSlider(
                items: <Widget>[
                  ThemeCard(Color(0XFF000000)),
                  ThemeCard(Color(0XFFE91E63)),
                  ThemeCard(Color(0XFF9C27B0)),
                  ThemeCard(Color(0XFF2196F3)),
                ],
                viewportFraction: 0.65,
                enableInfiniteScroll: false,
                initialPage: 0,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: RaisedButtonWidget("CONTINUE", () {}),
            ),
          )
        ],
      ),
    );
  }
}
