import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/services/firebase/firebase_auth.dart';

class SettingsHeader extends StatelessWidget {
  FirebaseAuthProvider _firebaseAuth = FirebaseAuthProvider();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebaseAuth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(snapshot.data.photoUrl),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data.displayName,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        snapshot.data.email,
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}
