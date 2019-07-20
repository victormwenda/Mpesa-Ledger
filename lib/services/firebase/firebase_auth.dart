import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<void> signIn() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print("YOU CANCELLED THE SIGNIN");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print("Error here " + e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }
  }
}