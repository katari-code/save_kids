import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class AuthBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');

  AuthBloc() {
    parent.addStream(_changeParent);
  }
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  Stream<Parent> get _parentSession => _repository.authSession;

  Stream<Parent> _parentData(String parentId) =>
      _repository.getDocument(Parent(), parentId);

  void setAccountPremuim() {
    parent.value.isPremium = "premium_account";

    _repository.setDocument(parent.value, parent.value.id);
  }

  get _changeParent {
    return _parentSession.switchMap<Parent>((value) {
      if (value == null) {
        return BehaviorSubject.seeded(null);
      }
      return _parentData(value.id)
          .switchMap<Parent>((parent) => BehaviorSubject.seeded(parent));
    });
  }
}
