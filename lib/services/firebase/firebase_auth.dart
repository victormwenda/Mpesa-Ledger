import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<void> signIn() async {
    print("no sign in");
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (_googleSignIn.currentUser != null) {
      await _googleSignIn.disconnect();
    }
  }
}
