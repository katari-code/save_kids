import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_kids/models/interfaces/i_firestore_converter.dart';

class Child implements FireStoreConverter {
  String name;
  String age;
  String imagePath;
  String type;
  String parentId;
  String id;
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
      this.age});
  Child.fromFirestore(DocumentSnapshot snapshot)
      : this(
            name: snapshot.data['name'],
            age: snapshot.data['age'],
            imagePath: snapshot.data['imagePath'],
            type: snapshot.data['type'],
            parentId: snapshot.data['parentId'],
            schedules:
                [...List.from(snapshot.data['schedules']).toList()] ?? [],
            id: snapshot.documentID);

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
    };
  }
}

class KidsData with ChangeNotifier {
  List<Child> kids = [
    Child(
      imagePath:
          "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-01.png?alt=media&token=aeb3748f-ff44-4628-921b-4268aea1c378",
      name: "Jacob",
      schedules: [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
    ),
    Child(
      imagePath:
          "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-02.png?alt=media&token=42e692af-8d9c-48cf-8142-02e1548e2465",
      name: "Alexander",
      schedules: [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
    ),
    Child(
      imagePath:
          "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
      name: "Isabella",
      schedules: [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
    ),
    // Child(
    //     "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
    //     "Isabella"),
  ];
  void addKid(Child child) {
    kids.add(child);
    notifyListeners();
  }
}
