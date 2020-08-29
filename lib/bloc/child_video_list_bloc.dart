import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';
import 'package:save_kids/util/style.dart';

class ChildVideoListBloc extends BlocBase {
  ChildVideoListBloc() {
    changeCategory(categoriesList[0]);
    timer.addStream(changeTimer);
    child.addStream(changeChild);
  }

  static String _pageToken = '';

  Repository _videoRepo = Repository();
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _childRepo = Repository<Child>(collection: 'children');

  BehaviorSubject<Timer> timer = BehaviorSubject<Timer>();
  Timer localTimer;
  BehaviorSubject<Child> child = BehaviorSubject<Child>();
  BehaviorSubject<String> childId = BehaviorSubject<String>();

  final _category = BehaviorSubject<Category>();

  void changeCategory(Category category) {
    if (category != _category.value) _pageToken = '';
    _category.sink.add(category);
    // fetchVideos();
  }

  updateTimer(Timer time) {
    localTimer = time;
  }

  Stream<Category> get streamCategory => _category.stream;
  Stream<Child> getChild(String id) {
    return _childRepo.getDocument(Child(), id);
  }

  get changeTimer {
    return childId.switchMap((value) {
      if (value != null) {
        return getChild(value).switchMap<Timer>((child) {
          if (child != null) {
            return BehaviorSubject.seeded(child.timer);
          } else {
            return BehaviorSubject.seeded(Timer());
          }
        });
      }
      return BehaviorSubject.seeded(Timer());
    });
  }

  get changeChild {
    return childId.switchMap((value) {
      if (value != null) {
        return getChild(value).switchMap<Child>((child) {
          // Logger().i('here in changeChild ', child);
          if (child != null) {
            return BehaviorSubject.seeded(child);
          } else {
            return BehaviorSubject.seeded(Child());
          }
        });
      }
      return BehaviorSubject.seeded(Child());
    });
  }

  get changeVideos {
    return _category.switchMap<List<Video>>((value) {
      return _videoRepo
          .getVideosBySearch(value.search, pageToken: _pageToken)
          .asStream()
          .switchMap<List<Video>>((map) {
        if (map != null) {
          _pageToken = map['pageToken'];
          return BehaviorSubject.seeded(map['data']);
        }
        return BehaviorSubject.seeded([]);
      });
    });
  }

  Future<List<Video>> fetchVideos() async {
    List<Video> videos = [];
    if (_category.value.categoryName == "Explor" &&
        child.value.specifyVideos.isNotEmpty) {
      final videosList = await _repository.getVideos(child.value.specifyVideos);
      videos = videosList;
    } else {
      final map = await _videoRepo.getVideosBySearch(_category.value.search,
          pageToken: _pageToken);
      videos.addAll(map['data']);
      _pageToken = map['pageToken'];
    }

    return videos;
  }

  //store it in the backend if the app is closed or on background
  Future storeTimer(String childId) async {
    Repository _repo = Repository<Child>(collection: 'children');
    Child getChild = await _repo.getDocument(Child(), childId).first;

    Child updatedChild = getChild..timer = localTimer;
    await _repo.setDocument(updatedChild, updatedChild.id);
  }

  Future updateWatchHistory(String videoId, String childId) async {
    Child value = await _repository.getDocument(Child(), childId).first;

    Child updatedChild = value..watchHistory.add(videoId);
    await _repository.setDocument(updatedChild, updatedChild.id);
  }

  @override
  void dispose() {
    _category.drain();
    print('disposing');
    timer.drain();

    localTimer = null;
    super.dispose();
  }
}
