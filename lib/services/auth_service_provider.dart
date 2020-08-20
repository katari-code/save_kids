import 'package:firebase_auth/firebase_auth.dart';

import 'package:save_kids/models/parent.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String uid;

  //check if there is any user session
  Stream<Parent> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<FirebaseUser> get currentUser {
    return _auth.currentUser();
  }

  Future<bool> get isEmailVerified async {
    FirebaseUser user = await currentUser;
    await user.reload();
    user = await currentUser;
    if (user.isEmailVerified) {
      return true;
    } else
      return false;
  }

  Future verifyEmail(FirebaseUser user) async {
    await user.sendEmailVerification();
  }

  //sign in
  Future<Parent> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;

    // verifyEmail(user);
    return _userFromFirebase(user);
  }

  signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    return _userFromFirebase(user);
  }

  Parent _userFromFirebase(FirebaseUser user) {
    if (user != null) {
      uid = user.uid;
      return Parent.fromFirebase(user);
    }
    return null;
  }

  //sign up
  Future<Parent> signUp(String email, String password) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await result.user.sendEmailVerification();
    return _userFromFirebase(result.user);
  }

  //logout user
  Future signOut() async {
    await _auth.signOut();
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  updateCurrentUser(FirebaseUser user, Parent parent) {
    if (parent.email != user.email && parent.email != null) {
      user.updateEmail(parent.email);
    }
    if (parent.password != null && parent.password.isNotEmpty) {
      user.updatePassword(parent.password);
    }

    user.reload();
  }
}
