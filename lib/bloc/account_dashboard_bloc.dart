import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/services/repository.dart';

class AccountDashboardBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _parentRepo = Repository<Parent>(collection: 'parent');
  Repository _schedulerepository = Repository<Schedule>(collection: 'schedule');

  String parentId;
  bool isNew = false;
  _getdata() async {
    await _repository.getChannel("UC6Dy0rQ6zDnQuHQ1EeErGUA");
  }

  AccountDashboardBloc() {
    _getdata();
    changeEditMode(false);
    checkIsEmailVerified;
    chosenDate.add(DateTime.now());
    children.addStream(_changeChildren);
    parent.addStream(_changeParent);
    schedules.addStream(changeSchedule);
    isEmailVerified.then((value) => {
          if (!value) {isNew = true}
        });
  }
  final _isEditMode = BehaviorSubject<bool>();
  BehaviorSubject<bool> isVerified = BehaviorSubject<bool>();
  BehaviorSubject<List<Child>> children = BehaviorSubject<List<Child>>();
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  BehaviorSubject<DateTime> chosenDate = BehaviorSubject<DateTime>();
  BehaviorSubject<String> chosenChild = BehaviorSubject<String>();
  BehaviorSubject<List<Schedule>> schedules = BehaviorSubject<List<Schedule>>();

  Function(bool) get changeEditMode => _isEditMode.sink.add;
  Stream<bool> get editMode => _isEditMode.stream;
  Future<bool> get isEmailVerified => _repository.isEmailVerified;
  Future get sendEmailVerification => _repository.sendEmailVerification;
  Stream<Parent> get parentSession => _repository.authSession;

  changeChosenChild(String chosenChildId) {
    chosenChild.add(chosenChildId);
  }

  get checkIsEmailVerified async {
    isVerified.add(await isEmailVerified);
  }

  Stream<List<Child>> get _changeChildren {
    return parentSession.switchMap((value) {
      if (value != null) {
        return _repository.getDocumentByQuery(Child(), 'parentId', value.id);
      } else {
        return BehaviorSubject.seeded([]);
      }
    });
  }

  Stream<Parent> get _changeParent {
    return parentSession.switchMap((value) {
      if (value != null) {
        return _parentRepo.getDocument(Parent(), value.id);
      } else {
        return BehaviorSubject.seeded(null);
      }
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

  Future deleteChild(String childId) async {
    return _repository.deleteDocument(Child(), childId);
  }

  @override
  void dispose() {
    _isEditMode.close();

    isVerified.close();
    isNew = false;
    super.dispose();
  }
}
