import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mpesa_ledger_flutter/screens/intro/reteiveing_sms_screen.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/flat_button.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';

class IntroWidget extends StatelessWidget {
  String title;
  String image;
  String description;

  IntroWidget(this.title, this.description, this.image);

  skip(BuildContext context) {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (route) => RetreiveSMS()));
  }

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
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButtonWidget("NEXT", () => {})),
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
