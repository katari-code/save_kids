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
  final List<Timer> timers = [
    Timer(lableText: "10 mins", lengthSec: (60 * 60), remainSec: (60 * 60)),
    Timer(lableText: "20 mins", lengthSec: (20 * 60), remainSec: (20 * 60)),
    Timer(lableText: "30 mins", lengthSec: (30 * 60), remainSec: (30 * 60)),
    Timer(
        lableText: "1 hr",
        lengthSec: (60 * 60 * 60),
        remainSec: (60 * 60 * 60)),
    Timer(
        lableText: "1:30 hr",
        lengthSec: (90 * 60 * 60),
        remainSec: (90 * 60 * 60)),
  ];

  void setCurrentTimer(int index) {
    currentTimerindex = index;
    Logger().d(index);
    notifyListeners();
  }

  void setRemainTimer(int index, int time) {
    timers[index].remainSec = time;
    // notifyListeners();
  }
}
