import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/i_firestore_converter.dart';

class Category implements FireStoreConverter {
  String id;
  String name;
  List<String> channelIds;
  Category({this.id, this.name, this.channelIds});

  Category.fromFireStore(DocumentSnapshot snapshot)
      : this(
          channelIds: [
            ...List<String>.from(snapshot.data['channels']).toList() ?? []
          ],
          id: snapshot.documentID,
          name: snapshot.data['name'],
        );

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Category.fromFireStore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'name': this.name,
      'channels': [...this.channelIds]
    };
  }
}
