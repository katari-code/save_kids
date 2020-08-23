import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

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
        .subtract(
          Duration(hours: dateTime.hour),
        )
        .add(
          Duration(days: 1),
        );
    Logger().i(dateTime);
    return scheduleCollection
        .where('childId', isEqualTo: childId)
        .where('dateStart',
            isGreaterThanOrEqualTo: dateTime.toUtc().subtract(
                  Duration(hours: dateTime.hour),
                ),
            isLessThanOrEqualTo: endTime)
        .snapshots()
        .map(super.list);
  }

  Stream<List<Schedule>> getDaySchedule(String childId) {
    final timenow = DateTime.now().toUtc();
    return scheduleCollection
        .where('childId', isEqualTo: childId)
        .where('dateStart', isLessThanOrEqualTo: timenow)
        .where('dateEnd', isGreaterThanOrEqualTo: timenow)
        .snapshots()
        .map(super.list);
  }
}
