import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/firestore_provider.dart';

class ScheduleProvider extends FireStoreProvider {
  ScheduleProvider()
      : super(Schedule(), Firestore.instance.collection('schedule'));
  Stream<List<Schedule>> getSchedules(String childId, DateTime dateTime) {
    final endTime = dateTime.add(Duration(
      days: 1,
    ));
    Logger().i(endTime.millisecondsSinceEpoch, dateTime.millisecondsSinceEpoch);
    return super
        .dataCollection
        // .where('childId', isEqualTo: childId)
        .where(
          'dateStart',
          isGreaterThanOrEqualTo: dateTime.millisecondsSinceEpoch,
        )
        .snapshots()
        .map((query) {
      Logger().i(query.documents);
      return super.list(query);
    });
  }
}
