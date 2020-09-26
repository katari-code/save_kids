import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/language_filiter.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';
import 'package:translator/translator.dart';

class SpecifyAddVideoBloc extends BlocBase {
  SpecifyAddVideoBloc() {
    _language.sink.add(languages[0]);
    // videoList.sink.add([]);
    child.addStream(changeChild);
    searchResult.add('');
    videosFromDB.addStream(changeVideosFromDB);
  }

  String _pageToken = '';
  Repository _repository = Repository();
  Repository _childRepo = Repository<Child>(collection: 'children');

  final searchResult = BehaviorSubject<String>();
  final _videoList = BehaviorSubject<List<Video>>();
  final child = BehaviorSubject<Child>();
  //videos from db
  final videosFromDB = BehaviorSubject<List<Video>>();
  // final videos = ReplaySubject<List<Video>>();
  final _language = BehaviorSubject<Language>();
  BehaviorSubject<String> childId = BehaviorSubject<String>();

  Function(String) get changeSearchResult => searchResult.sink.add;
  Function(List<Video>) get changeVideoList => _videoList.sink.add;

  Function(Language) get changeLanguage => _language.sink.add;

  Stream<Child> get changeChild {
    return childId.switchMap((value) {
      if (value != null) {
        return getChild(value).switchMap<Child>((child) {
          // Logger().i('here in changeChild ', child);
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

  Stream<List<Video>> get changeVideosFromDB {
    return child.switchMap<List<Video>>((value) {
      if (value != null) {
        return getChosenVideosDB(value.specifyVideos)
            .switchMap<List<Video>>((videos) {
          // Logger().i('here in changeChild ', child);
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

  addChosenVideo(String videoId) {
    List<Video> videos = _videoList.value.map((video) {
      Logger().i(video.id);
      if (video.id == videoId) {
        Video editedVideo = video..chosen = !video.chosen;
        return editedVideo;
      }
      return video;
    }).toList();
    return changeVideoList(videos);
  }

  reset() {
    changeVideoList(videosFromDB.value);
  }

  changeChosenVideosFromDB(String videoId) {
    List<Video> videos = videosFromDB.value.map((video) {
      if (video.id == videoId) {
        Video editedVideo = video..chosen = !video.chosen;
        return editedVideo;
      }
      return video;
    }).toList();
    videosFromDB.add(videos);
    // videosFromDB.pipe(streamConsumer)
  }

  Stream<List<Video>> getChosenVideosDB(List<String> videos) {
    return _repository.getVideos(videos).asStream();
  }

  Stream<Child> getChild(String value) {
    return _childRepo.getDocument(Child(), value);
  }

  Stream<Language> get language => _language.stream;

  Stream<String> get search =>
      searchResult.stream.transform(_validateSearchResult);
  Stream<List<Video>> get videos => _videoList.stream;

  final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) async {
    if (search.length > 1) {
      sink.add(search.trim());
    }
  });

  Future getVideoBySearch(bool isSearched) async {
    if (isSearched) {
      _pageToken = '';
    }
    if (searchResult.value.isEmpty) {
      return;
    }
    var _searchResultTransleated =
        await searchResult.value.translate(to: _language.value.lnCode);
    //page token for videos
    // print('${_pageToken.isEmpty} :' + _pageToken);
    final previousVids =
        _pageToken.isNotEmpty ? _videoList.value : List<Video>.from([]);

    final map = await _repository.getVideosBySearch(
        _searchResultTransleated.toString(),
        pageToken: _pageToken);
    _pageToken = map['pageToken'];

    List<Video> videos = [
      ...previousVids,
      ...List<Video>.from(map['data']).toList(),
    ].toSet().toList();
    changeVideoList(videos);
  }

  Future updateSpecifyVideos(String childId) async {
    List<Video> chosenVideosFromSearch = returnChosenVideos();

    final chosenVideos = chosenVideosFromSearch.toSet().toList();
    List<String> viedosId = [];

    chosenVideos.forEach((video) {
      viedosId.add(video.id);
    });
    Child updatedChild = child.value..specifyVideos = viedosId;
    await _childRepo.setDocument(updatedChild, updatedChild.id);
  }

  List<Video> returnChosenVideos() {
    return [
      ..._videoList.value.where((element) => element.chosen == true).toList(),
    ];
  }

  getVideosByToken() async {
    //get the previous videos
    //
  }

  @override
  dispose() {
    print('disposing...');
    searchResult.close();
    _language.close();
    _videoList.close();
    childId.close();
    // searchResult.add(null);

    // videoList.add(null);
    super.dispose();
  }

  final List<Language> languages = [
    Language(lnName: "English", lnCode: "en"),
    Language(lnName: "Spanish", lnCode: "es"),
    Language(lnName: "German", lnCode: "de"),
    Language(lnName: "French", lnCode: "fr"),
  ];
}
