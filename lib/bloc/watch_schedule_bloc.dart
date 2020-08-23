import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/repository.dart';

class WatchScheduleBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _schedulerepository = Repository<Schedule>(collection: 'schedule');
  BehaviorSubject<String> chosenChild = BehaviorSubject<String>();
  BehaviorSubject<DateTime> chosenDate = BehaviorSubject<DateTime>();
  BehaviorSubject<List<Schedule>> schedules = BehaviorSubject<List<Schedule>>();
  BehaviorSubject<List<Child>> children = BehaviorSubject<List<Child>>();

  WatchScheduleBloc() {
    chosenDate.add(DateTime.now());
    children.addStream(changeChildren);
    schedules.addStream(changeSchedule);
  }
  changeChosenChild(String chosenChildId) {
    chosenChild.add(chosenChildId);
  }

  changeChosenDate(DateTime date) {
    chosenDate.add(date);
  }

  Stream<Parent> get parentSession => _repository.authSession;

  Stream<List<Child>> get changeChildren {
    return parentSession.switchMap((parent) {
      if (parent != null) {
        return _repository.getDocumentByQuery(Child(), 'parentId', parent.id);
      }
      return BehaviorSubject.seeded([]);
    });
  }

  Stream<List<Schedule>> get changeSchedule {
    return chosenChild.switchMap<List<Schedule>>((child) {
      return chosenDate.switchMap((date) {
        if (date != null && child != null) {
          return _schedulerepository.getSchedules(child, date);
        } else {
          return BehaviorSubject.seeded([]);
        }
      });
    });
  }

  deleteSchedule(String scheduleId) async {
    await _schedulerepository.deleteDocument(Schedule(), scheduleId);
  }

  @override
  void dispose() {
    chosenDate.drain();
    chosenChild.drain();
    schedules.drain();
    children.drain();
    super.dispose();
  }
}
