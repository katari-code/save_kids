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
    languages.forEach((element) => print(element.lnName));
    _language.sink.add(languages[0]);
    _videoList.sink.add([]);
  }

  String _pageToken = '';
  Repository _repository = Repository();
  Repository _childRepo = Repository<Child>(collection: 'children');

  final _searchResult = BehaviorSubject<String>();
  final _videoList = BehaviorSubject<List<Video>>();
  final _language = BehaviorSubject<Language>();

  Function(String) get changeSearchResult => _searchResult.sink.add;
  Function(List) get changeVideoList => _videoList.sink.add;
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

  Future<List<Video>> getChosenVideosDB(List<String> videos) async {
    final videosList = await _repository.getVideos(videos);
    videosList.forEach((element) {
      element.chosen = true;
    });
    _videoList.sink.add(videosList);
    return videosList;
  }

  Future<List<Video>> initVideos(String childId) async {
    Child child = await _childRepo.getDocument(Child(), childId).first;
    List<Video> viedos = await getChosenVideosDB(child.specifyVideos);
    return viedos;
  }

  Future updateSpecifyVideos(String childId) async {
    Child value = await _childRepo.getDocument(Child(), childId).first;
    final List<Video> viedos = returnChosenVideos();
    List<String> viedosId = [];

    viedos.forEach((video) {
      viedosId.add(video.id);
    });

    Child updatedChild = value..specifyVideos = viedosId;
    await _childRepo.setDocument(updatedChild, updatedChild.id);
    await getChosenVideosDB(viedosId);
  }

  Stream<Language> get language => _language.stream;

  Stream<String> get searchResult =>
      _searchResult.stream.transform(_validateSearchResult);
  // Stream<List<Channel>> get channels=> _ch
  Stream<List<Video>> get videos => _videoList.stream;

  final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
      handleData: (search, sink) async {
    if (search.length > 1) {
      sink.add(search.trim());
    } else {}
  });

  Future getVideoBySearch() async {
    var _searchResultTransleated =
        await _searchResult.value.translate(to: _language.value.lnCode);
    Logger().i(
        _searchResultTransleated.toString() + "   " + _language.value.lnCode);
    final map = await _repository.getVideosBySearch(
        _searchResultTransleated.toString(),
        pageToken: _pageToken);
    _pageToken = map['pageToken'];
    changeVideoList(map['data']);
  }

  List<Video> returnChosenVideos() {
    return _videoList.value.where((element) => element.chosen == true).toList();
  }

  @override
  void dispose() async {
    await _searchResult.drain();
    _searchResult.close();
    await _videoList.drain();
    _videoList.close();
    super.dispose();
  }

  final List<Language> languages = [
    Language(lnName: "English", lnCode: "en"),
    Language(lnName: "Spanish", lnCode: "es"),
    Language(lnName: "German", lnCode: "de"),
    Language(lnName: "French", lnCode: "fr"),
  ];
}
