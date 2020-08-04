import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleData with ChangeNotifier {
  DateTime currentDay = DateTime.now();

  ScheduleData() {
    setCurrentDay(
      DateTime.now(),
    );
  }

  void setCurrentDay(DateTime newDate) {
    currentDay = DateTime(newDate.year, newDate.month, newDate.day);
    // dateInfo[currentDay] == null
    //     ? dateInfo[currentDay] = []
    //     : notifyListeners();
    // notifyListeners();
  }
}
