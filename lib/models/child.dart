import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';
import 'package:save_kids/models/timer.dart';

class Child implements FireStoreConverter {
  String name;
  String age;
  String imagePath;
  String type;
  String parentId;
  String id;
  Timer timer;
  List<String> watchHistory;
  List<dynamic> schedules;
  Child(
      {this.imagePath,
      this.name,
      this.parentId,
      this.watchHistory,
      this.schedules,
      this.type,
      this.id,
      this.timer,
      this.age});
  Child.fromFirestore(DocumentSnapshot snapshot)
      : this(
          name: snapshot.data['name'],
          age: snapshot.data['age'],
          imagePath: snapshot.data['imagePath'],
          type: snapshot.data['type'],
          parentId: snapshot.data['parentId'],
          schedules: [...List.from(snapshot.data['schedules']).toList()] ?? [],
          timer: Timer.fromFirestore(snapshot.data['timer']),
          id: snapshot.documentID,
          watchHistory: [
                ...List<String>.from(snapshot.data['watchHistory']).toList()
              ] ??
              [],
        );

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Child.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'name': this.name,
      'age': this.age,
      'imagePath': this.imagePath,
      'type': this.type,
      'schedules': this.schedules ?? [],
      'parentId': this.parentId,
      'timer': this.timer.toFireStore(),
      'watchHistory': this.watchHistory ?? []
    };
  }
}
