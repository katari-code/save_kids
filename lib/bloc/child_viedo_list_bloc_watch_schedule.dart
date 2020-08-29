import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/schedule.dart';

import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';

class ChildVideoListWSBloc extends BlocBase {
  ChildVideoListWSBloc() {
    changeCategory(categoriesList[0]);
    child.addStream(changeChild);
    schedule.addStream(changeSchedule);
    videosFromDB.addStream(changeVideosFromDB);
  }

  static String _pageToken = '';

  Repository _videoRepo = Repository();
  Repository _childRepo = Repository<Child>(collection: 'children');
  Repository _schRepo = Repository<Schedule>(collection: 'schedule');

  BehaviorSubject<Child> child = BehaviorSubject<Child>();
  BehaviorSubject<String> childId = BehaviorSubject<String>();

  BehaviorSubject<Schedule> schedule = BehaviorSubject<Schedule>();
  BehaviorSubject<String> scheduleId = BehaviorSubject<String>();
  BehaviorSubject<List<String>> videosList = BehaviorSubject<List<String>>();
  BehaviorSubject<List<Channel>> channels = BehaviorSubject<List<Channel>>();

  final videosFromDB = BehaviorSubject<List<Video>>();

  final _category = BehaviorSubject<Category>();

  void changeCategory(Category category) {
    if (category != _category.value) _pageToken = '';
    _category.sink.add(category);
    // fetchVideos();
  }

  Stream<Category> get streamCategory => _category.stream;
  Stream<List<Channel>> get streamChannels => channels.stream;

  Stream<Child> getChild(String id) {
    return _childRepo.getDocument(Child(), id);
  }

  Stream<Schedule> getSchedule(String id) {
    return _schRepo.getDocument(Schedule(), id);
  }

  changeChosenVideosFromDB(String videoId) {
    List<Video> videos = videosFromDB.value.map((video) {
      return video;
    }).toList();
    videosFromDB.add(videos);
  }

  Stream<List<Video>> getChosenVideosDB(List<String> videos) {
    return _videoRepo.getVideos(videos).asStream();
  }

  get changeVideosFromDB {
    return schedule.switchMap<List<Video>>((value) {
      if (value != null) {
        return getChosenVideosDB(value.videos).switchMap<List<Video>>((videos) {
          if (videos != null) {
            videos.forEach((element) {
              element.chosen = true;
            });
            return BehaviorSubject.seeded(videos);
          } else {
            return BehaviorSubject.seeded([]);
          }
        });
      }
      return BehaviorSubject.seeded([]);
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

  get changeSchedule {
    return scheduleId.switchMap((value) {
      if (value != null) {
        return getSchedule(value).switchMap<Schedule>((schedule) {
          // Logger().i('here in changeSchedule ', schedule);
          if (schedule != null) {
            List<Channel> tempChannels = [];
            for (int i = 0; i < schedule.channels.length; i++) {
              _videoRepo.getChannel(schedule.channels[i]).then((channle) {
                tempChannels.add(channle);
              });
            }
            channels.sink.add(tempChannels);
            return BehaviorSubject.seeded(schedule);
          } else {
            return BehaviorSubject.seeded(Schedule());
          }
        });
      }
      return BehaviorSubject.seeded(Schedule());
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
    final map = await _videoRepo.getVideosBySearch(_category.value.search,
        pageToken: _pageToken);
    videos.addAll(map['data']);
    _pageToken = map['pageToken'];
    return videos;
  }

  Future updateWatchHistory(String videoId, String childId) async {
    Child value = await _childRepo.getDocument(Child(), childId).first;

    Child updatedChild = value..watchHistory.add(videoId);
    await _childRepo.setDocument(updatedChild, updatedChild.id);
  }

  @override
  void dispose() {
    _category.drain();
    print('disposing');
    channels.drain();
    videosList.drain();
    super.dispose();
  }
}
