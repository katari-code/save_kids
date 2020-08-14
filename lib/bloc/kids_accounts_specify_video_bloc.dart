import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class KidsAccountsSpecifyVideosBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _parentRepo = Repository<Parent>(collection: 'parent');
  String parentId;

  KidsAccountsSpecifyVideosBloc() {
    children.addStream(_changeChildren);
    parent.addStream(_changeParent);
    parentSession.map((event) => parentId = event.id);
  }

  BehaviorSubject<List<Child>> children = BehaviorSubject<List<Child>>();
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  Stream<Parent> get parentSession => _repository.authSession;

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

  @override
  void dispose() async {
    super.dispose();
  }
}
