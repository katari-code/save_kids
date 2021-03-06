import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/repository.dart';

class VideoListBloc extends BlocBase {
  VideoListBloc() {
    changeCategory(categories[1]);
  }
  // static List<String> _pageTokens = [];
  // static List<String> _playListIds = [];
  static String _pageToken = '';
  Repository _repository;
  final _category = BehaviorSubject<Category>();
  void changeCategory(Category category) {
    if (category != _category.value) _pageToken = '';
    _category.sink.add(category);
  }

  Stream<Category> get streamCategory => _category.stream;
  Future<List<Video>> fetchVideos() async {
    _repository = Repository();
    List<Video> videos = [];

    final map = await _repository.getVideosBySearch(_category.value.search,
        pageToken: _pageToken);
    videos.addAll(map['data']);
    _pageToken = map['pageToken'];

    return videos;
  }

  @override
  void dispose() {
    _category.drain();
    super.dispose();
  }
  // Future<List<Video>> fetchvideos(Category category, String typeOfChild) async {
  //   _repository = Repository<Category>(collection: 'category');

  //   //get the playlistids of that category
  //   _playListIds = await _repository.getChannelsPlayListIds(category);
  //   //initializing the pagetokens
  //   if (_pageTokens.length == 0) {
  //     _pageTokens = List.generate(_playListIds.length, (index) => ' ');
  //   }

  //   //get the map that consists of videos and tokens
  //   List<Video> videos = [];
  //   for (var i = 0; i < _playListIds.length; i++) {
  //     final map = await _repository.getVideosByPlayListId(
  //         _playListIds[i], _pageTokens[i]);
  //     videos.addAll(map['videos']);
  //     _pageTokens[i] = map['pageToken'];
  //   }
  //   return videos;
  // }

}

final categories = [
  Category(
    'Explore',
    'Explore for kids',
    index: 0,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fccexploer.png?alt=media&token=f7ecff35-9621-4f14-9e4c-8dd60c204605",
    v1: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fv2_explore.svg?alt=media&token=007b4f77-c012-4b8e-bddd-a92bfaa1b2b7",
  ),
  Category(
    'Education',
    'science for kids',
    index: 1,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fceducation%408x.png?alt=media&token=b6250206-7d7e-452b-91b7-fd40bc847ac1",
    v1: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fedu_v2.svg?alt=media&token=a719a517-20f9-47ed-8f0d-a13d24248acd",
    v2: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fedu_v1.svg?alt=media&token=2dfd82f6-a25c-4b4e-a5bc-30853e38ab03",
  ),
  Category(
    'Shows',
    'Shows for kids',
    index: 2,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fcshows%408x.png?alt=media&token=a1d71049-0fc7-43e6-b331-c3480f00e25e",
  ),
  Category(
    'Music',
    'Music for kids',
    index: 3,
    isSelected: true,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fcmusic%408x.png?alt=media&token=0626f186-a4f2-4672-bd1e-1610d911c986",
    v1: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fv1_music.svg?alt=media&token=8a66eca3-6cb4-4615-b67b-caf02a007998",
    v2: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fv2_music.svg?alt=media&token=1892cedd-473b-4135-a7ff-605845066178",
  ),
  Category(
    'Cartoon',
    'cartoon for kids',
    isSelected: false,
    index: 4,
    imgURl:
        "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fccartoon.png?alt=media&token=87b155a9-611b-4cfc-92fe-04167f7ed0c6",
    v1: "https://firebasestorage.googleapis.com/v0/b/save-video-kids.appspot.com/o/categories%2Fv1_explore.svg?alt=media&token=2679baed-fe78-4d97-afe0-8d70456a3946",
  ),
];
