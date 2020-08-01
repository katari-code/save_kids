import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/firestore_converter.dart';

class FireStoreProvider<T extends FireStoreConverter> {
  final CollectionReference dataCollection;
  FireStoreConverter converter;
  // ignore: avoid_init_to_null
  String id = null;
  String whereId;
  FireStoreProvider(this.converter, this.dataCollection,
      {this.id, this.whereId});

  Stream<T> get document {
    return dataCollection.document(id).snapshots().map(_dataFromSnap);
  }

  Stream<List<T>> documentList(String query, String id) {
    return dataCollection.where(query, isEqualTo: '$id').snapshots().map(list);
  }

  Stream<List<T>> get documentListArrayContains {
    return dataCollection
        .where(whereId, arrayContains: id)
        .snapshots()
        .map(list);
  }

  Future setData() async {
    return await dataCollection.document(id).setData(converter.toFireStore());
  }

  Future<DocumentReference> get addDocument async {
    return await dataCollection.add(converter.toFireStore());
  }

  //map it to an appoitment object
  T _dataFromSnap(DocumentSnapshot snap) {
    return converter.fromFireStore(snap);
  }

  ///map a list of patient
  List<T> list(QuerySnapshot snapshots) {
    return snapshots.documents.map(_dataFromSnap).toList();
  }
}
