import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_kids/models/i_firestore_converter.dart';

class Parent extends FireStoreConverter {
  String id;
  String email;
  String password;
  Parent({this.email, this.id, this.password});

  Parent.fromFirebase(FirebaseUser user)
      : this(id: user.uid, email: user.email);

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    // TODO: implement fromFireStore
    throw UnimplementedError();
  }

  @override
  toFireStore() {
    // TODO: implement toFireStore
    throw UnimplementedError();
  }
}
