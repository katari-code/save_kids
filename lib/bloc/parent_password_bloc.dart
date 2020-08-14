import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class ParentPasswordBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');
  ParentPasswordBloc() {
    parent.addStream(parentSession.switchMap((session) {
      if (session != null) return getParent(session);
      return BehaviorSubject.seeded(null);
    }));
  }
  BehaviorSubject<String> password = BehaviorSubject<String>();
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  Stream<Parent> get parentSession => _repository.authSession;
  Stream<Parent> getParent(Parent parentSession) {
    return _repository.getDocument(Parent(), parentSession.id);
  }

  @override
  void dispose() {
    password.drain();
    super.dispose();
  }

  bool verifyPassword() {
    if (password.value.trim() == parent.value.password) {
      return true;
    }
    return false;
  }
}
