import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';

import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/models/video_report.dart';
import 'package:save_kids/services/repository.dart';

class ChildVideoListBloc extends BlocBase {
  ChildVideoListBloc() {
    timer.addStream(changeTimer);
    child.addStream(changeChild);
    changeCategory(categoriesList[0]);
  }

  static String _pageToken = '';

  Repository _videoRepo = Repository<VideoReport>(collection: 'video_reports');
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

  //get parent session
  Stream<Parent> get parentSession {
    return _repository.authSession;
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

  Stream<List<VideoReport>> get fetchBlockedVideos {
    return parentSession.switchMap((session) {
      if (session != null) {
        return _videoRepo.getDocumentByQuery(
            VideoReport(), 'parent', session.id);
      }
      return BehaviorSubject.seeded(null);
    });
  }

  Future<List<Video>> filterVideos(List<Video> videos) async {
    final blockedVideos = await fetchBlockedVideos.first;
    List<Video> filteredVideos = [...videos];

    for (var video in videos) {
      for (var blockedVideo in blockedVideos) {
        if (blockedVideo.videoId == video.id) {
          filteredVideos.remove(video);
        }
      }
    }
    return filteredVideos;
  }

  removeVideoAfterVideoReport(String videoId) {
    List<Video> videos = [...videoList.value];
    videos.removeWhere((element) => element.id == videoId);
    videoList.add([...videos]);
  }

  Future<void> fetchVideos() async {
    final map = await _videoRepo.getVideosBySearch(category.value.search,
        pageToken: _pageToken);
    List<Video> previousVids = [];

    if (_pageToken != '') {
      previousVids.addAll(
        videoList.hasValue == true ? videoList.value : List<Video>.from([]),
      );
    }
    _pageToken = map['pageToken'];

    List<Video> videos = [
      ...previousVids,
      ...(await filterVideos(List<Video>.from(map['data']).toList()))
      // ...List<Video>.from(map['data']).toList()
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
    category.add(null);
    timer.add(null);
    videoList.add(null);
    localTimer = null;
    super.dispose();
  }
}
