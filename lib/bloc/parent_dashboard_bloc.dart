import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class ParentDashBoardBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');

  ParentDashBoardBloc() {
    parent.addStream(changeParent);
  }
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();

  get changeParent {
    return parentSession.switchMap((value) {
      if (value != null) {
        return _repository.getDocument(Parent(), value.id);
      }
      return BehaviorSubject.seeded(Parent());
    });
  }

  Stream<Parent> get parentSession => _repository.authSession;
}
