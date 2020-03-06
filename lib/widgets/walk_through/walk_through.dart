import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalkThroughWidget extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  WalkThroughWidget(this.title, this.description, this.image);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SvgPicture.asset(
              image,
              height: 250.0,
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(title,
                            style: Theme.of(context).textTheme.display1)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          description,
                          style: Theme.of(context).textTheme.subhead,
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
