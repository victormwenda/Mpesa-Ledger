import 'package:flutter/material.dart';

import 'package:mpesa_ledger_flutter/blocs/bottombar_navigation/bottombar_nav_bloc.dart';
import 'package:mpesa_ledger_flutter/screens/home/main_home.dart';
import 'package:mpesa_ledger_flutter/screens/intro/splash_screen.dart';
import 'package:mpesa_ledger_flutter/services/firebase/firebase_auth.dart';
import 'package:mpesa_ledger_flutter/widgets/bottom_navigation_bar/bottom_navigation.dart';

class App extends StatefulWidget {

  final FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();
  final BottombarNavigationBloc bottombarNavigationBloc = BottombarNavigationBloc();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    widget.firebaseAuthProvider.onAuthStateChanged.listen((data) {
      if(data == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (route) => SplashScreen()),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() { 
    widget.bottombarNavigationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: StreamBuilder(
        initialData: MainHome(),
        stream: widget.bottombarNavigationBloc.screensControllerStream,
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          return snapshot.data;
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(widget.bottombarNavigationBloc),
    );
  }
}