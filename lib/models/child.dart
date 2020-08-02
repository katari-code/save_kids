import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_kids/models/i_firestore_converter.dart';

class Child implements FireStoreConverter {
  String name;
  String imagePath;
  String type;
  String parentId;
  List<dynamic> schedules;
  Child({this.imagePath, this.name, this.parentId, this.schedules, this.type});

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

class KidsData with ChangeNotifier {
  List<Child> kids = [
    Child(
        imagePath:
            "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-01.png?alt=media&token=aeb3748f-ff44-4628-921b-4268aea1c378",
        name: "Jacob"),
    Child(
        imagePath:
            "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-02.png?alt=media&token=42e692af-8d9c-48cf-8142-02e1548e2465",
        name: "Alexander"),
    Child(
        imagePath:
            "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
        name: "Isabella"),
    // Child(
    //     "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
    //     "Isabella"),
  ];
  void addKid(Child child) {
    kids.add(child);
    notifyListeners();
  }
}
