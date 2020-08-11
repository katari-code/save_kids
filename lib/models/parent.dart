import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class Parent extends FireStoreConverter {
  String id;
  String email;
  String name;
  String password;
  String pin;
  // String type;
  List<dynamic> children;
  Parent(
      {this.email, this.id, this.password, this.pin, this.children, this.name});

  Parent.fromFirebase(FirebaseUser user)
      : this(id: user.uid, email: user.email);

  Parent.fromFirestore(DocumentSnapshot snapshot)
      : this(
          email: snapshot.data['email'],
          pin: snapshot.data['pin'],
          id: snapshot.documentID,
          name: snapshot.data['name'],
          children:
              [...List<String>.from(snapshot.data['children']).toList()] ?? [],
        );

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Parent.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'email': this.email,
      'pin': this.pin,
      'children': this.children ?? [],
      'name': this.name
    };
  }
}
