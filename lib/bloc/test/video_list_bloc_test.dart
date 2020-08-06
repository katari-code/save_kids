import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
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

class Category {
  String categoryName;
  String search;
  Category(this.categoryName, this.search);
}

final categories = [
  Category('toys', 'toys for kids'),
  Category('science', 'science for kids'),
  Category('cartoon', 'cartoon for kids'),
];
