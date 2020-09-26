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

  final searchResult = BehaviorSubject<String>();
  final _videoList = BehaviorSubject<List<Video>>();
  final _language = BehaviorSubject<Language>();
  AddVideoBloc() {
    _videoList.add([]);
    _language.add(languages[0]);
    searchResult.add('');
  }

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

  // Stream<List<Channel>> get channels=> _ch
  Stream<List<Video>> get videos => _videoList.stream;

  Future getVideoBySearch(bool isSearched) async {
    if (isSearched) {
      _pageToken = '';
    }
    if (searchResult.value.isEmpty) {
      return;
    }
    var _searchResultTransleated =
        await searchResult.value.translate(to: _language.value.lnCode);

    final previousVids =
        _pageToken.isNotEmpty ? _videoList.value : List<Video>.from([]);

    final map = await _repository.getVideosBySearch(
        _searchResultTransleated.toString(),
        pageToken: _pageToken);
    _pageToken = map['pageToken'];
    //pagetoekn

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
  void dispose() {
    searchResult.close();

    _videoList.close();

    super.dispose();
  }
}
