import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class AuthBloc extends BlocBase {
  Repository _repository = Repository<Parent>(collection: 'parent');
  Stream<Parent> get parentSession => _repository.authSession;

  Stream<Parent> parentData(String parentId) =>
      _repository.getDocument(Parent(), parentId);
}
