import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';

class ChildVideoListSpecifyBloc extends BlocBase {
  ChildVideoListSpecifyBloc() {
    timer.addStream(changeTimer);
    child.addStream(changeChild);
    videosFromDB.addStream(changeVideosFromDB);
  }

  Repository _repository = Repository<Child>(collection: 'children');
  Repository _childRepo = Repository<Child>(collection: 'children');

  BehaviorSubject<Timer> timer = BehaviorSubject<Timer>();
  Timer localTimer;
  BehaviorSubject<Child> child = BehaviorSubject<Child>();
  BehaviorSubject<String> childId = BehaviorSubject<String>();

  BehaviorSubject<List<Video>> videosFromDB = BehaviorSubject<List<Video>>();

  updateTimer(Timer time) {
    localTimer = time;
  }

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

  get changeVideosFromDB {
    return child.switchMap<List<Video>>((value) {
      if (value != null) {
        return getChosenVideosDB(value.specifyVideos)
            .switchMap<List<Video>>((videos) {
          if (videos != null) {
            return BehaviorSubject.seeded(videos);
          } else {
            return BehaviorSubject.seeded([]);
          }
        });
      }
      return BehaviorSubject.seeded([]);
    });
  }

  Stream<List<Video>> getChosenVideosDB(List<String> videos) {
    return _repository.getVideos(videos).asStream();
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
    print('disposing');
    timer.drain();
    videosFromDB.drain();
    localTimer = null;
    super.dispose();
  }
}
