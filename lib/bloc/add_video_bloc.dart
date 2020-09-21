import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/language_filiter.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';
import 'package:translator/translator.dart';

class AddVideoBloc extends BlocBase {
  String _pageToken = '';
  Repository _repository = Repository();

  final _searchResult = BehaviorSubject<String>();
  final _videoList = BehaviorSubject<List<Video>>();
  final _language = BehaviorSubject<Language>();
  AddVideoBloc() {
    _videoList.add([]);
    _language.add(languages[0]);
  }

  Function(String) get changeSearchResult => _searchResult.sink.add;
  Function(List<Video>) get changeVideoList => _videoList.sink.add;
  Function(Language) get changeLanguage => _language.sink.add;

  addChosenVideo(String channelId) {
    List<Video> videos = _videoList.value.map((video) {
      if (video.id == channelId) {
        Video editedVideo = video..chosen = !video.chosen;
        return editedVideo;
      }
      return video;
    }).toList();
    return changeVideoList(videos);
  }

  Stream<String> get searchResult =>
      _searchResult.stream.transform(_validateSearchResult);
  // Stream<List<Channel>> get channels=> _ch
  Stream<List<Video>> get videos => _videoList.stream;

  final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) {
    if (search.length > 1) {
      sink.add(search.trim());
    } else {
      // sink.addError('search should be more than 5');
    }
  });

  Future getVideoBySearch(bool isSearched) async {
    if (isSearched) {
      _pageToken = '';
    }
    var _searchResultTransleated =
        await _searchResult.value.translate(to: _language.value.lnCode);
    final map = await _repository.getVideosBySearch(
        _searchResultTransleated.toString(),
        pageToken: _pageToken);
    _pageToken = map['pageToken'];
    //pagetoekn
    final previousVids =
        _videoList.hasValue == true ? _videoList.value : List<Video>.from([]);
    List<Video> videos = [
      ...previousVids,
      ...List<Video>.from(map['data']).toList()
    ].toSet().toList();
    changeVideoList(videos);
  }

  List<Video> returnChosenVideos() {
    return _videoList.value.where((element) => element.chosen == true).toList();
  }

  final List<Language> languages = [
    Language(lnName: "English", lnCode: "en"),
    Language(lnName: "Spanish", lnCode: "es"),
    Language(lnName: "German", lnCode: "de"),
    Language(lnName: "French", lnCode: "fr"),
  ];

  @override
  void dispose() async {
    await _searchResult.drain();
    _searchResult.close();
    await _videoList.drain();
    _videoList.close();
    super.dispose();
  }
}
