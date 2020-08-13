import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';

class WatchHistoryBloc extends BlocBase {
  Repository _repository = Repository<Child>(collection: 'children');
  BehaviorSubject<List<Child>> children = BehaviorSubject<List<Child>>();

  WatchHistoryBloc() {
    children.addStream(changeChildren);
  }
  Stream<Parent> get parentSession => _repository.authSession;
  Stream<List<Child>> get changeChildren {
    return parentSession.switchMap((parent) {
      if (parent != null) {
        return _repository.getDocumentByQuery(Child(), 'parentId', parent.id);
      }
      return BehaviorSubject.seeded([]);
    });
  }

  Future<List<Video>> getVideos(List<String> videos) async {
    return _repository.getVideos(videos);
  }

  // Stream<List<Child>>
  @override
  void dispose() {
    super.dispose();
  }
}
