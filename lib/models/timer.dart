import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:timer_count_down/timer_controller.dart';

class Timer {
  final int lengthSec;
  int remainSec;
  String lableText;
  bool isComplete;

  Timer({this.lableText, this.lengthSec, this.remainSec, this.isComplete});

  Timer.fromFirestore(Map<String, dynamic> timer)
      : this(
            lengthSec: timer['lengthSec'],
            remainSec: timer['remainSec'],
            lableText: timer['lableText'],
            isComplete: timer['isComplete']);

  @override
  fromFireStore(Map<String, dynamic> timer) {
    return Timer.fromFirestore(timer);
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

class TimerData with ChangeNotifier {
  final CountdownController controller = CountdownController();

  int currentTimerindex = 0;

  void setCurrentTimer(int index) {
    currentTimerindex = index;
    Logger().d(index);
    notifyListeners();
  }
}
