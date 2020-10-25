import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/services/repository.dart';
import 'package:save_kids/util/constant.dart';

class ParentDashBoardBloc extends BlocBase {
  Repository _childRepo = Repository<Child>(collection: 'children');
  Repository _repository = Repository<Parent>(collection: 'parent');
  String parentId;

  ParentDashBoardBloc() {
    parent.addStream(changeParent);
    children.addStream(_changeChildren);
    parentSession.map((event) => parentId = event.id);
  }
  BehaviorSubject<List<Child>> children = BehaviorSubject<List<Child>>();
  BehaviorSubject<Parent> parent = BehaviorSubject<Parent>();
  Stream<Parent> get parentSession => _repository.authSession;

  Stream<Parent> get changeParent {
    return parentSession.switchMap((value) {
      if (value != null) {
        return _repository.getDocument(Parent(), value.id);
      }
      return BehaviorSubject.seeded(Parent());
    });
  }

  Stream<List<Child>> get _changeChildren {
    return parentSession.switchMap((value) {
      if (value != null) {
        return _childRepo.getDocumentByQuery(Child(), 'parentId', value.id);
      } else {
        return BehaviorSubject.seeded([]);
      }
    });
  }

  Future deleteChild(String childId) async {
    return _childRepo.deleteDocument(Child(), childId);
  }

  Future changeMode(String childId, int index) async {
    Child getChild = await _childRepo.getDocument(Child(), childId).first;
    if (index == 0) {
      Logger().i(index);
      Child updatedChild = getChild..type = kAccountype[0];
      await _childRepo.setDocument(updatedChild, updatedChild.id);
    } else if (index == 1) {
      Logger().i(index);
      Child updatedChild = getChild..type = kAccountype[1];
      await _childRepo.setDocument(updatedChild, updatedChild.id);
    } else if (index == 2) {
      Logger().i(index);
      Child updatedChild = getChild..type = kAccountype[2];
      await _childRepo.setDocument(updatedChild, updatedChild.id);
    }
  }

  void setAccountPremuim() {
    parent.value.isPremium = "premium_account";
    _repository.setDocument(parent.value, parent.value.id);
  }

  @override
  void dispose() async {
    super.dispose();
  }
}
