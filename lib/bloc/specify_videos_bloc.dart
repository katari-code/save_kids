// import 'dart:async';

// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:save_kids/models/video.dart';
// import 'package:save_kids/services/repository.dart';

//copy form orgainal file --> Credit: Dev.Khaaild
// class SpecifyAddVideoBloc extends BlocBase {
//   String _pageToken = '';
//   Repository _repository = Repository();

//   final _searchResult = BehaviorSubject<String>();
//   final _videoList = BehaviorSubject<List<Video>>();

//   Function(String) get changeSearchResult => _searchResult.sink.add;
//   Function(List) get changeVideoList => _videoList.sink.add;
//   addChosenVideo(String channelId) {
//     List<Video> videos = _videoList.value.map((video) {
//       if (video.id == channelId) {
//         Video editedVideo = video..chosen = !video.chosen;
//         return editedVideo;
//       }
//       return video;
//     }).toList();
//     return changeVideoList(videos);
//   }

//   Stream<String> get searchResult =>
//       _searchResult.stream.transform(_validateSearchResult);
//   Stream<List<Video>> get videos => _videoList.stream;

//   final _validateSearchResult = StreamTransformer<String, String>.fromHandlers(
//       handleData: (search, sink) {
//     if (search.length > 1) {
//       sink.add(search.trim());
//     } else {
//       // sink.addError('search should be more than 5');
//     }
//   });

//   Future getVideoBySearch() async {
//     final map = await _repository.getVideosBySearch(_searchResult.value,
//         pageToken: _pageToken);
//     _pageToken = map['pageToken'];
//     changeVideoList(map['data']);
//   }

//   List<Video> returnChosenVideos() {
//     return _videoList.value.where((element) => element.chosen == true).toList();
//   }

//   @override
//   void dispose() async {
//     await _searchResult.drain();
//     _searchResult.close();
//     await _videoList.drain();
//     _videoList.close();
//     super.dispose();
//   }
// }
