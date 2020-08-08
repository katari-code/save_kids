import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/util/style.dart';

class Category {
  String categoryName;
  String search;
  bool isSelected;
  Color color;
  Category(this.categoryName, this.search, {this.color, this.isSelected});
}

final categories = [
  Category('toys', 'toys for kids', color: kRedDarkColor, isSelected: true),
  Category('science', 'science for kids',
      color: kYellowColor, isSelected: true),
  Category('cartoon', 'cartoon for kids',
      color: kBlueDarkColor, isSelected: false),
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
