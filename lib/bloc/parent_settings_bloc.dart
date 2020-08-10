import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class ParentSettingsBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeName => _name.sink.add;

  changeParent(Parent parent) {
    changeName(parent.name);
  }

  Stream<String> get name => _name.stream;
  Stream<String> get password => _password.stream;
  Stream<String> get email => _email.stream;

  Stream<Parent> get parentSession => _repository.authSession;
  Stream<Parent> getParent(Parent parentSession) {
    changeEmail(parentSession.email);
    changeEmail(parentSession.password);
    return _repository.getDocument(Parent(), parentSession.id);
  }

  @override
  void dispose() {
    _email.drain();
    _name.drain();
    _password.drain();
    super.dispose();
  }
}
