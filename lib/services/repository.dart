import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/youtube_api_provider.dart';

class Repository<T> {
  YoutubeApiProvider _youtubeApi;
  Future<List<Video>> getVideosBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Video>();
    return _youtubeApi.fetchBySearch(
        mapper: Video(), search: search, type: 'video');
  }

  Future<List<Channel>> getChannelsBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Channel>();
    return _youtubeApi.fetchBySearch(
        mapper: Channel(), search: search, type: 'channel');
  }
}
