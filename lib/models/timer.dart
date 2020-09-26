import 'package:cloud_firestore/cloud_firestore.dart';
import 'interfaces/i_firestore_converter.dart';

class Timer implements FireStoreConverter {
  int lengthSec;
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

final List<Timer> timers = [
  Timer(
      lableText: "60 sec", lengthSec: (60), remainSec: (60), isComplete: false),
  Timer(
      lableText: "05 mins",
      lengthSec: (5 * 60),
      remainSec: (5 * 60),
      isComplete: false),
  Timer(
      lableText: "10 mins",
      lengthSec: (10 * 60),
      remainSec: (10 * 60),
      isComplete: false),
  Timer(
      lableText: "20 mins",
      lengthSec: (20 * 60),
      remainSec: (20 * 60),
      isComplete: false),
  Timer(
      lableText: "30 mins",
      lengthSec: (30 * 60),
      remainSec: (30 * 60),
      isComplete: false),
  Timer(
      lableText: "1:00 hr",
      lengthSec: (60 * 60),
      remainSec: (60 * 60),
      isComplete: false),
  Timer(
      lableText: "1:30 hr",
      lengthSec: (90 * 60),
      remainSec: (90 * 60),
      isComplete: false),
  Timer(
      lableText: "2:00 hr",
      lengthSec: (120 * 60),
      remainSec: (120 * 60),
      isComplete: false),
  Timer(
      lableText: "2:30 hr",
      lengthSec: (150 * 60),
      remainSec: (150 * 60),
      isComplete: false),
];
