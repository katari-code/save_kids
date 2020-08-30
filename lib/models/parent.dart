import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class Parent extends FireStoreConverter {
  String id;
  String email;
  String name;
  String password;
  String isPremium;

  // String type;
  List<dynamic> children;
  Parent(
      {this.email,
      this.id,
      this.password,
      this.children,
      this.name,
      this.isPremium});

  Parent.fromFirebase(FirebaseUser user)
      : this(id: user.uid, email: user.email, name: user.displayName);

  Parent.fromFirestore(DocumentSnapshot snapshot)
      : this(
          email: snapshot.data['email'],
          password: snapshot.data['password'],
          id: snapshot.documentID,
          name: snapshot.data['name'],
          children:
              [...List<String>.from(snapshot.data['children']).toList()] ?? [],
          isPremium: snapshot.data['isPremium'] ?? "free_account",
        );

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Parent.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'email': this.email,
      'password': this.password,
      'children': this.children ?? [],
      'name': this.name,
      'isPremium': this.isPremium ?? "free_account",
    };
  }
}
