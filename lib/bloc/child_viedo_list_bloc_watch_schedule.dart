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
    channels.add([]);
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
  BehaviorSubject<List<Video>> videoList = BehaviorSubject<List<Video>>();
  BehaviorSubject<List<Channel>> channels = BehaviorSubject<List<Channel>>();
  BehaviorSubject<Channel> chosenChannel = BehaviorSubject<Channel>();
  BehaviorSubject<List<Video>> playList = BehaviorSubject<List<Video>>();

  final videosFromDB = BehaviorSubject<List<Video>>();

  final _category = BehaviorSubject<Category>();

  void changeCategory(Category category) {
    if (category != _category.value) _pageToken = '';
    _category.sink.add(category);
    fetchVideos();
  }

  void changechosenChannel(int index) {
    if (chosenChannel.hasValue) {
      chosenChannel.value.pageToken = '';
    }
    chosenChannel.add(channels.value[index]);
    fetchPlayList();
  }

  Stream<Category> get streamCategory => _category.stream;
  Stream<List<Channel>> get streamChannels => channels.stream;

  Stream<Child> getChild(String id) {
    return _childRepo.getDocument(Child(), id);
  }

  Stream<Schedule> getSchedule(String id) {
    return _schRepo.getDocument(Schedule(), id);
  }

  Stream<List<Video>> getChosenVideosDB(List<String> videos) {
    return _videoRepo.getVideos(videos).asStream();
  }

  get changeVideosFromDB {
    return schedule.switchMap<List<Video>>((value) {
      if (value != null) {
        return getChosenVideosDB(value.videos).switchMap<List<Video>>((videos) {
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
              _videoRepo.getChannel(schedule.channels[i]).then((channel) {
                tempChannels.add(channel);
              });
            }
            channels.add(tempChannels);
            return BehaviorSubject.seeded(schedule);
          } else {
            return BehaviorSubject.seeded(Schedule());
          }
        });
      }
      return BehaviorSubject.seeded(Schedule());
    });
  }

  Future<void> fetchVideos() async {
    final map = await _videoRepo.getVideosBySearch(_category.value.search,
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

  Future<void> fetchPlayList({String channelId}) async {
    //get the videos from the specific channel
    // Channel channel =
    //     channels.value.firstWhere((element) => element.id == channelId);
    final map = await _videoRepo.getPlayList(
        chosenChannel.value.pageToken, chosenChannel.value.uploadPlaylistId);

    ///add the videos with the previous channel
    // channel.videos.addAll(map['data']);
    // channel.videos = channel.videos.toSet().toList();
    // channel.pageToken = map['pageToken'];

    //put it back to sink
    // channels.add(channels.value.map((previousChannel) {
    //   if (channel.id == previousChannel.id) return channel;
    //   return previousChannel;
    // }).toList());
    List<Video> previousVids = [];
    if (chosenChannel.value.pageToken != '') {
      previousVids.addAll(
        playList.hasValue == true ? playList.value : List<Video>.from([]),
      );
    }
    chosenChannel.add(chosenChannel.value..pageToken = map['pageToken']);
    final videos = [...previousVids, ...List<Video>.from(map['data']).toList()];
    playList.add(videos);
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
    videoList.drain();
    super.dispose();
  }
}
