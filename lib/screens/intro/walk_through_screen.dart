import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/walk_through/walk_through.dart';
import 'package:mpesa_ledger_flutter/screens/intro/choose_theme.dart';
import 'package:mpesa_ledger_flutter/screens/intro/reteiveing_sms_screen.dart';
import 'package:mpesa_ledger_flutter/widgets/buttons/raised_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(WalkThrough());

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  final WalkThroughBloc walkThroughBloc = WalkThroughBloc();
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    walkThroughBloc.initializeWalkThrough();
    super.initState();
  }

  @override
  void dispose() {
    walkThroughBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Widget>>(
        stream: walkThroughBloc.walkThroughControllerStream,
        builder: (context, snapshot) {
          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                itemCount: snapshot.data.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return snapshot.data[index];
                },
                onPageChanged: (int index) {
                  walkThroughBloc.changePageEventSink.add(index);
                },
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 30.0, bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SmoothPageIndicator(
                          controller: _pageController, // PageController
                          count: snapshot.data.length,
                          effect: WormEffect(
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 10.0,
                            dotColor: Colors.black12,
                          ),
                        ),
                        StreamBuilder<int>(
                            stream: walkThroughBloc.changePageEventStream,
                            initialData: 0,
                            builder: (context, snapshot2) {
                              if (snapshot2.data !=
                                  (snapshot.data.length - 1)) {
                                return RaisedButtonWidget("NEXT", () {
                                  var nextPage = snapshot2.data + 1;
                                  _pageController.animateToPage(nextPage,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  walkThroughBloc.changePageEventSink
                                      .add(nextPage);
                                });
                              }
                              return RaisedButtonWidget("CONTINUE", () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (route) => ChooseThemeWidget(true)));
                              });
                            })
                      ],
                    ),
                  )
                ],
              )
            ],
          );
        });
  }
}
