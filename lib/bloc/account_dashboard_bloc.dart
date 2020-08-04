import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class AccountDashboardBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  AccountDashboardBloc() {
    changeEditMode(false);
  }
  final _isEditMode = BehaviorSubject<bool>();
  Function(bool) get changeEditMode => _isEditMode.sink.add;
  Stream<bool> get editMode => _isEditMode.stream;

  Stream<Parent> get parentSession => _repository.authSession;

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
    super.dispose();
  }
}
