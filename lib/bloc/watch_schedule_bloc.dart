import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/repository.dart';

class WatchScheduleBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _schedulerepository = Repository<Schedule>(collection: 'schedule');
  final _chosenChild = BehaviorSubject<String>();
  final _chosenDate = BehaviorSubject<DateTime>();
  final _schedules = BehaviorSubject<List<Schedule>>();
  WatchScheduleBloc() {
    changeChosenDate(DateTime.now());
  }
  changeChosenChild(String chosenChildId) {
    _chosenChild.sink.add(chosenChildId);
    changeSchedule();
  }
  changeChosenDate(DateTime date) {
    _chosenDate.sink.add(date);
    changeSchedule();
  }

  Function(List) get changeScheduleDate => _schedules.sink.add;

  Stream<String> get chosenChild => _chosenChild.stream;
  Stream<Parent> get parentSession => _repository.authSession;
  Stream<DateTime> get chosenDate => _chosenDate.stream;
  Stream<List<Schedule>> get schedules => _schedules.stream;

  Stream<List<Child>> children(String parentId) {
    return _repository.getDocumentByQuery(Child(), 'parentId', parentId);
  }

  changeSchedule() async {
    final schedules = await _schedulerepository
        .getSchedules(_chosenChild.value, _chosenDate.value)
        .first;
    _schedules.sink.add(schedules);
  }

  // Future<List<Schedule>> getSchedules()

  deleteSchedule(String scheduleId) async {
    await _schedulerepository.deleteDocument(Schedule(), scheduleId);
    changeSchedule();
  }

  @override
  void dispose() {
    _chosenDate.drain();
    _chosenChild.drain();
    _schedules.drain();
    super.dispose();
  }
}
