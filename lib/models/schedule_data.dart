import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_kids/models/show_time.dart';

class ScheduleData with ChangeNotifier {
  ScheduleData();
  DateTime currentDate = DateTime.now();
  var currentChild = 0;
  static const daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<ShowTimeCard> _showTimes = [];

  List<ShowTimeCard> getChildShowTime() {
    List<ShowTimeCard> childShowTime = _showTimes
        .where((item) =>
            item.timeStart.difference(currentDate).inDays == 0 &&
            item.childId == currentChild)
        .toList();
    return childShowTime;
  }

  addToSchedule(ShowTimeCard card) {
    _showTimes.add(card);
    notifyListeners();
  }

  setcurrentDate(DateTime newDate) {
    currentDate = DateTime(newDate.year, newDate.month, newDate.day);
    notifyListeners();
  }

  setCurrentChild(int index) {
    currentChild = index;
    notifyListeners();
  }
}
