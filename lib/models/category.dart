import 'dart:ui';

import 'package:save_kids/util/style.dart';

class Category {
  int index;
  String categoryName;
  String search;
  bool isSelected;
  Color color;
  String imgURl;
  String v1; // Vector 1
  String v2; // Vector 2
  Category(
    this.categoryName,
    this.search, {
    this.color,
    this.isSelected,
    this.imgURl,
    this.index,
    this.v1,
    this.v2,
  });
}

final categoriesList = [
  // Category(
  //   'toys',
  //   'toys for kids',
  //   color: kRedDarkColor,
  //   isSelected: true,
  // ),
  Category(
    'Explor',
    'Explor for kids',
    color: kYellowColor,
    index: 0,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fccexploer.png?alt=media&token=f7ecff35-9621-4f14-9e4c-8dd60c204605",
  ),
  Category(
    'Education',
    'science for kids',
    index: 1,
    color: kYellowColor,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fceducation%408x.png?alt=media&token=b6250206-7d7e-452b-91b7-fd40bc847ac1",
    v1: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fedu_v2.svg?alt=media&token=a719a517-20f9-47ed-8f0d-a13d24248acd",
    v2: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fedu_v2.svg?alt=media&token=a719a517-20f9-47ed-8f0d-a13d24248acd",
  ),
  Category(
    'Shows',
    'Shows for kids',
    index: 2,
    color: kYellowColor,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fcshows%408x.png?alt=media&token=a1d71049-0fc7-43e6-b331-c3480f00e25e",
  ),
  Category(
    'Music',
    'science for kids',
    color: kYellowColor,
    index: 3,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fcmusic%408x.png?alt=media&token=0626f186-a4f2-4672-bd1e-1610d911c986",
  ),
  Category('Cartoon', 'cartoon for kids',
      color: kBlueDarkColor,
      isSelected: false,
      index: 4,
      imgURl:
          "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fccartoon.png?alt=media&token=87b155a9-611b-4cfc-92fe-04167f7ed0c6"),
];

// class Category implements FireStoreConverter {
//   String id;
//   String name;
//   List<String> channelIds;
//   Category({this.id, this.name, this.channelIds});

//   Category.fromFireStore(DocumentSnapshot snapshot)
//       : this(
//           channelIds: [
//             ...List<String>.from(snapshot.data['channels']).toList() ?? []
//           ],
//           id: snapshot.documentID,
//           name: snapshot.data['name'],
//         );

//   @override
//   fromFireStore(DocumentSnapshot snapshot) {
//     return Category.fromFireStore(snapshot);
//   }

//   @override
//   toFireStore() {
//     return {
//       'name': this.name,
//       'channels': [...this.channelIds]
//     };
//   }
// }
