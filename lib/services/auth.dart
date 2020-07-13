import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  Stream<User> get user {
    return auth.onAuthStateChanged
        .map((FirebaseUser user) => userFromFirebaseUser(user));
  }

  // sign in with google
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final AuthResult result = await auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;

    assert(!user.isAnonymous);
    assert(user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return userFromFirebaseUser(user);
  }

  // sign out
  Future signOut() async {
    try {
      auth.signOut();
      return await googleSignIn.signOut();
    } catch (e) {
      print('ERROR: ' + e.toString());
      return null;
    }
  }
}
