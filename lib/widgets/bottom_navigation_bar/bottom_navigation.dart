import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mpesa_ledger_flutter/blocs/bottombar_navigation/bottombar_nav_bloc.dart';
import 'package:mpesa_ledger_flutter/utils/enums/enums.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottombarNavigationBloc bottombarNavigationBloc = BottombarNavigationBloc();

  BottomNavigationBarWidget(this.bottombarNavigationBloc);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.bottombarNavigationBloc.selectIndexEventStream,
        initialData: 0,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 3.0),
            child: BubbleBottomBar(
              opacity: .3,
              iconSize: 20,
              currentIndex: snapshot.data,
              onTap: (int index) {
                widget.bottombarNavigationBloc.selectIndexEventSink.add(index);
                widget.bottombarNavigationBloc.changeScreenEventSink
                    .add(Screens.values[index]);
              },
              borderRadius: BorderRadius.all(Radius.circular(15)),
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              items: <BubbleBottomBarItem>[
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).accentColor,
                    icon: FaIcon(FontAwesomeIcons.home, color: Colors.white54),
                    activeIcon: FaIcon(
                      FontAwesomeIcons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .merge(TextStyle(fontSize: 16.5, color: Colors.white)),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).accentColor,
                    icon: FaIcon(FontAwesomeIcons.calculator, color: Colors.white54),
                    activeIcon: FaIcon(
                      FontAwesomeIcons.calculator,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Calculator",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .merge(TextStyle(fontSize: 16.5, color: Colors.white)),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).accentColor,
                    icon: FaIcon(FontAwesomeIcons.history, color: Colors.white54),
                    activeIcon: FaIcon(
                      FontAwesomeIcons.history,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Summary",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .merge(TextStyle(fontSize: 16.5, color: Colors.white)),
                    )),
                BubbleBottomBarItem(
                    backgroundColor: Theme.of(context).accentColor,
                    icon: FaIcon(FontAwesomeIcons.layerGroup, color: Colors.white54),
                    activeIcon: FaIcon(
                      FontAwesomeIcons.layerGroup,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Category",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .merge(TextStyle(fontSize: 16.5, color: Colors.white)),
                    ))
              ],
            ),
          );
        });
  }
}
