import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/firestore_provider.dart';

class ScheduleProvider extends FireStoreProvider<Schedule> {
  final CollectionReference scheduleCollection =
      Firestore.instance.collection('schedule');
  ScheduleProvider()
      : super(new Schedule(), Firestore.instance.collection('schedule'));
  Stream<List<Schedule>> getSchedules(String childId, DateTime dateTime) {
    final endTime = dateTime
        .toUtc()
        .subtract(Duration(hours: dateTime.hour + 6))
        .add(Duration(days: 1));
    // Logger()
    //     .i(dateTime.toUtc().subtract(Duration(hours: dateTime.hour)), endTime);
    return scheduleCollection
        .where('childId', isEqualTo: childId)
        .where('dateStart',
            isGreaterThanOrEqualTo:
                dateTime.toUtc().subtract(Duration(hours: dateTime.hour + 6)),
            isLessThanOrEqualTo: endTime)
        .snapshots()
        .map(super.list);
  }
}
