import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class Schedule implements FireStoreConverter {
  final String id;
  final String childId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final List<String> categories;
  final List<String> videos;
  final List<String> channels;
  final String day;
  Schedule(
      {this.id,
      this.childId,
      this.day,
      this.categories,
      this.dateEnd,
      this.channels,
      this.dateStart,
      this.videos});
  Schedule.fromFirestore(DocumentSnapshot snapshot)
      : this(
          id: snapshot.documentID,
          childId: snapshot.data['childId'],
          // day: snapshot.data['day'] ?? '',
          categories: [
                ...List<String>.from(snapshot.data['categories']).toList()
              ] ??
              [],

          dateEnd: snapshot.data['dateEnd'].toDate().toLocal(),
          dateStart: snapshot.data['dateStart'].toDate().toLocal(),
          channels:
              [...List<String>.from(snapshot.data['channels']).toList()] ?? [],
          videos:
              [...List<String>.from(snapshot.data['videos']).toList()] ?? [],
        );
  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Schedule.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'childId': this.childId,
      'day': this.day,
      'categories': this.categories,
      'dateStart': this.dateStart.toLocal(),
      'dateEnd': this.dateEnd.toLocal(),
      'videos': this.videos ?? [],
      'channels': this.channels ?? [],
    };
  }
}
