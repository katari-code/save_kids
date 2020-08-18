import 'package:cloud_firestore/cloud_firestore.dart';
import 'interfaces/i_firestore_converter.dart';

class Timer implements FireStoreConverter {
  final int lengthSec;
  int remainSec;
  String lableText;
  bool isComplete;

  Timer({this.lableText, this.lengthSec, this.remainSec, this.isComplete});

  Timer.fromJson(Map<String, dynamic> json)
      : this(
          lengthSec: json['lengthSec'],
          remainSec: json['remainSec'],
          lableText: json['lableText'],
          isComplete: json['isComplete'],
        );

  Map<String, dynamic> toJson() => {
        'isComplete': this.isComplete,
        'lableText': this.lableText,
        'remainSec': this.remainSec,
        'lengthSec': this.lengthSec,
      };

  Timer.fromFirestore(DocumentSnapshot snapshot)
      : this(
            lengthSec: snapshot.data['lengthSec'],
            remainSec: snapshot.data['remainSec'],
            lableText: snapshot.data['lableText'],
            isComplete: snapshot.data['isComplete']);

  @override
  fromFireStore(DocumentSnapshot snapshot) {
    return Timer.fromFirestore(snapshot);
  }

  @override
  toFireStore() {
    return {
      'lengthSec': this.lengthSec,
      'remainSec': this.remainSec,
      'lableText': this.lableText,
      'isComplete': this.isComplete,
    };
  }
}
