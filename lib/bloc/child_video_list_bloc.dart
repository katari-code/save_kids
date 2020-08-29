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
    timer.addStream(changeTimer);
    child.addStream(changeChild);
    changeCategory(categoriesList[0]);
  }

  static String _pageToken = '';

  Repository _videoRepo = Repository();
  Repository _repository = Repository<Child>(collection: 'children');
  Repository _childRepo = Repository<Child>(collection: 'children');

  BehaviorSubject<Timer> timer = BehaviorSubject<Timer>();
  Timer localTimer;
  BehaviorSubject<Child> child = BehaviorSubject<Child>();
  BehaviorSubject<String> childId = BehaviorSubject<String>();

  BehaviorSubject<List<Video>> videoList = BehaviorSubject<List<Video>>();

  final category = BehaviorSubject<Category>();

  void changeCategory(Category newCategory) {
    if (newCategory != category.value) {
      _pageToken = '';
    }

    category.sink.add(newCategory);

    fetchVideos();
  }

  updateTimer(Timer time) {
    localTimer = time;
  }

  Stream<Category> get streamCategory => category.stream;
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

  Stream<Child> get changeChild {
    return childId.switchMap<Child>((value) {
      if (value != null) {
        return getChild(value).switchMap<Child>((child) {
          if (child != null) {
            return BehaviorSubject.seeded(child);
          } else {
            return BehaviorSubject.seeded(null);
          }
        });
      }
      return BehaviorSubject.seeded(null);
    });
  }

  Future<void> fetchVideos() async {
    final map = await _videoRepo.getVideosBySearch(category.value.search,
        pageToken: _pageToken);
    List<Video> previousVids = [];

    //check if we are still in our previous category
    //if it is the same add all previous videos with the new ones
    if (_pageToken != '') {
      previousVids.addAll(
        videoList.hasValue == true ? videoList.value : List<Video>.from([]),
      );
    }
    _pageToken = map['pageToken'];
    List<Video> videos = [
      ...previousVids,
      ...List<Video>.from(map['data']).toList()
    ].toSet().toList();
    videoList.add(videos);
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
    category.drain();
    timer.drain();
    videoList.drain();
    localTimer = null;
    super.dispose();
  }
}
