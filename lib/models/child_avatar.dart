import 'package:flutter/material.dart';

class ChildAvatar {
  int index;
  String childAvatar;

  ChildAvatar(this.index, this.childAvatar);
}

class AvatarData with ChangeNotifier {
  var currentAvatar = 0;

  List<ChildAvatar> avatars = [
    ChildAvatar(0,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-01.png?alt=media&token=aeb3748f-ff44-4628-921b-4268aea1c378"),
    ChildAvatar(1,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-02.png?alt=media&token=42e692af-8d9c-48cf-8142-02e1548e2465"),
    ChildAvatar(2,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/b-03.png?alt=media&token=657ad3ac-7dd4-4bc2-b3d2-71f90e9852e4"),
    ChildAvatar(3,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-01.png?alt=media&token=5933af5f-3e97-4ae0-b09d-c73f5b84d630"),
    ChildAvatar(4,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-02.png?alt=media&token=d80f18e6-6310-487c-8fe7-53fc08a9a1eb"),
    ChildAvatar(5,
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/g-03.png?alt=media&token=e6c687d8-63aa-46a6-a2d5-ccc87daf3432"),
  ];

  void setCurrentAvatr(int index) {
    currentAvatar = index;
    notifyListeners();
  }
}
