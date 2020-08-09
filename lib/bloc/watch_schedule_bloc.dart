import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/repository.dart';

class WatchScheduleBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  final _chosenChild = BehaviorSubject<String>();
  final _chosenDate = BehaviorSubject<DateTime>();
  WatchScheduleBloc() {
    changeChosenDate(DateTime.now());
  }
  Function(String) get changeChosenChild => _chosenChild.sink.add;
  Function(DateTime) get changeChosenDate => _chosenDate.sink.add;
  Stream<String> get chosenChild => _chosenChild.stream;
  Stream<Parent> get parentSession => _repository.authSession;
  Stream<DateTime> get chosenDate => _chosenDate.stream;

  Stream<List<Child>> children(String parentId) =>
      _repository.getDocumentByQuery(Child(), 'parentId', parentId);
  Stream<List<Schedule>> getSchedule() {
    //check the difference time and the child id
    return _repository.getSchedules(_chosenChild.value,
        _chosenDate.value.toLocal().subtract(Duration(hours: 20)));
  }

  @override
  void dispose() {
    _chosenDate.drain();
    _chosenChild.drain();
    super.dispose();
  }
}
