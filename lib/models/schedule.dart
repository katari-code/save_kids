import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class Schedule implements FireStoreConverter {
  final String id;
  final String childId;
  final String timeStart;
  final String timeEnd;
  final List<dynamic> categories;
  final List<String> videos;
  final List<String> days;
  Schedule(
      {this.id,
      this.childId,
      this.days,
      this.categories,
      this.timeEnd,
      this.timeStart,
      this.videos});
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
