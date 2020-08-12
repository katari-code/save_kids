import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class AccountDashboardBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _parentRepo = Repository<Parent>(collection: 'parent');
  String parentId;
  bool isNew = false;
  AccountDashboardBloc() {
    changeEditMode(false);
    checkIsEmailVerified;
    _repository.isEmailVerified.then((value) => {
          if (!value) {isNew = true}
        });
  }
  final _isEditMode = BehaviorSubject<bool>();
  BehaviorSubject<bool> isVerified = BehaviorSubject<bool>();
  Function(bool) get changeEditMode => _isEditMode.sink.add;
  Stream<bool> get editMode => _isEditMode.stream;
  // Stream<bool> get isEmailVerified => isVerified.stream;
  get checkIsEmailVerified async {
    isVerified.add(await isEmailVerified);
    // isEmailVerified;
  }

  Future<bool> get isEmailVerified => _repository.isEmailVerified;

  Future get sendEmailVerification => _repository.sendEmailVerification;

  Stream<Parent> get parentSession => _repository.authSession;
  Stream<Parent> get parent => _parentRepo.getDocument(Parent(), parentId);

  Stream<List<Child>> children(String parentId) {
    return _repository.getDocumentByQuery(Child(), 'parentId', parentId);
  }

  Future deleteChild(String childId) async {
    return _repository.deleteDocument(Child(), childId);
  }

  @override
  void dispose() async {
    await _isEditMode.drain();
    _isEditMode.close();
    isVerified.drain();
    super.dispose();
  }
}
