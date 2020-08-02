import 'package:logger/logger.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/services/youtube_api_provider.dart';

class Repository<T> {
  YoutubeApiProvider _youtubeApi;
  Logger logger = Logger();

  Future<List<Video>> getVideosBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Video>();
    try {
      return _youtubeApi.fetchBySearch(
          mapper: Video(), search: search, type: 'video');
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<List<Channel>> getChannelsBySearch(String search) async {
    _youtubeApi = YoutubeApiProvider<Channel>();
    try {
      return _youtubeApi.fetchBySearch(
          mapper: Channel(), search: search, type: 'channel');
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
