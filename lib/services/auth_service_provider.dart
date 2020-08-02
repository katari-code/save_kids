import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_kids/models/parent.dart';

class AuthServiceProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid;
  //check if there is any user session
  Stream<Parent> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in
  Future<Parent> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
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
    FirebaseUser user = result.user;
    return _userFromFirebase(user);
  }

  //logout user
  Future signOut() async {
    await _auth.signOut();
  }
}
