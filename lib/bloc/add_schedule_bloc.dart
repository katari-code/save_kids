import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';

class AddScheduleBloc extends BlocBase {
  String childId;
  AddScheduleBloc() {
    changeTimeEnd(TimeOfDay.now());
    changeTimeStart(TimeOfDay.now());
    addCategories(categories);
  }
  Repository _repository = Repository<Schedule>(collection: 'schedule');
  final _chosenVideos = BehaviorSubject<List<Video>>();
  final _chosenChannels = BehaviorSubject<List<Channel>>();
  final _timeStart = BehaviorSubject<TimeOfDay>();
  final _timeEnd = BehaviorSubject<TimeOfDay>();
  final _duration = BehaviorSubject<String>();
  final _categories = BehaviorSubject<List<Category>>();
  Function(List<Video>) get addChosenVideos => _chosenVideos.sink.add;
  Function(List<Channel>) get addChosenChannels => _chosenChannels.sink.add;
  Function(List) get addCategories => _categories.sink.add;
  addChosenCategories(String categoryName) {
    List<Category> categoryList = _categories.value.map((category) {
      if (category.categoryName == categoryName) {
        Category editedCategory = category..isSelected = !category.isSelected;
        return editedCategory;
      }
      return category;
    }).toList();
    return addCategories(categoryList);
  }

  changeTimeStart(TimeOfDay time) {
    _timeStart.sink.add(time);
    uptimeDuration();
  }

  changeTimeEnd(TimeOfDay time) {
    _timeEnd.sink.add(time);
    uptimeDuration();
  }

  Stream<TimeOfDay> get timeStart => _timeStart.stream;
  Stream<TimeOfDay> get timeEnd => _timeEnd.stream;
  Stream<String> get duration => _duration.stream;
  Stream<List<Category>> get categoryList => _categories.stream;
  double toDouble(TimeOfDay myTime) {
    if (myTime != null) {
      return myTime.hour + myTime.minute / 60.0;
    }
    return 0;
  }

  uptimeDuration() {
    final start = toDouble(_timeStart.value);
    final end = toDouble(_timeEnd.value);
    if (start < end) {
      final result = end - start;
      var tag = "";
      double decimal = result - result.floor();
      String mins = (decimal * 60).floor().toString();

      result.floor() > 0
          ? result.floor() > 1 ? tag = "hours" : tag = "hour"
          : tag = "mins";

      _duration.sink.add("${result.floor()} : $mins  $tag");
    }
  }

  Future addSchedule() async {
    final now = DateTime.now();
    final dateSt = DateTime(now.year, now.month, now.day, _timeStart.value.hour,
        _timeStart.value.minute);

    final dateEn = DateTime(now.year, now.month, now.day, _timeEnd.value.hour,
        _timeEnd.value.minute);

    List<String> categories = _categories.value
        .where((event) => event.isSelected == true)
        .map((e) => e.search)
        .toList();
    Schedule schedule = Schedule(
      categories: categories,
      channels: _chosenChannels.value.map((e) => e.id).toSet().toList(),
      videos: _chosenVideos.value.map((e) => e.id).toSet().toList(),
      childId: childId,
      dateEnd: dateEn.toString(),
      dateStart: dateSt.toString(),
    );
    return _repository.addDocument(schedule);
  }

  @override
  void dispose() {
    _chosenVideos.drain();
    _chosenChannels.drain();
    _timeStart.drain();
    _timeEnd.drain();
    _duration.drain();
    _categories.drain();
    super.dispose();
  }
}
