import 'package:flutter/material.dart';

class ShowTimeCard {
  int childId;
  DateTime timeStart;
  DateTime timeEnd;
  List<String> categories;
  List<String> videos;

  ShowTimeCard(
      {this.childId,
      this.timeStart,
      this.timeEnd,
      this.categories,
      this.videos});
}
