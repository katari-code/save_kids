import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireStoreConverter {
  toFireStore();
  fromFireStore(DocumentSnapshot snapshot);
  // FireStoreConverter.fromFirebase(DocumentSnapshot snapshot);
}
