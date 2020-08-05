import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';

class WrapperBloc extends BlocBase {
  Repository _repository = Repository<Parent>();

  Stream<Parent> get parentSession => _repository.authSession;
}
