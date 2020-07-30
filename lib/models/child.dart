import 'package:flutter/cupertino.dart';

class Child {
  String name;
  String imagePath;

  Child(this.imagePath, this.name);
}

class KidsData with ChangeNotifier {
  List<Child> kids = [
    Child(
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-01.png?alt=media&token=aeb3748f-ff44-4628-921b-4268aea1c378",
        "Jacob"),
    Child(
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-02.png?alt=media&token=42e692af-8d9c-48cf-8142-02e1548e2465",
        "Alexander"),
    Child(
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
        "Isabella"),
    // Child(
    //     "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb",
    //     "Isabella"),
  ];
  void addKid(Child child) {
    kids.add(child);
    notifyListeners();
  }
}
