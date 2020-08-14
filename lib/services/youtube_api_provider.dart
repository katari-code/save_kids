import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/interfaces/i_mapper.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/util/keys.dart';

class YoutubeApiProvider<T> {
  // YoutubeApiProvider._constructor();
  // static final instance = YoutubeApiProvider<T>._constructor();

  final baseUrl = "www.googleapis.com";
  String _nextPageToken = '';
  static String pageToken = '';
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<Map> fetchBySearchCategory(
      {Mapper mapper, String search, String type, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'type': type,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': API_KEY,
      'safeSearch': 'strict',
      'q': search
    };
    Uri uri = Uri.https(
      baseUrl,
      'youtube/v3/search',
      parameters,
    );

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      pageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<T> collection = [];
      videosJson.forEach(
        (json) => collection.add(
          mapper.fromSearchMap(json),
        ),
      );
      return {'data': collection, 'pageToken': pageToken};
    } else {
      Logger().e(json.decode(response.body)['error']['message']);
      return {'data': List<T>.from([]).toList(), 'pageToken': ''};
    }
  }

  Future<List<Video>> fetchVideoList({List<String> videos}) async {
    String videoIds = '';
    videos.forEach((video) {
      videoIds += '$video,';
    });
    Map<String, String> parameters = {
      'part': 'snippet',
      'type': 'video',
      'id': videoIds,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      'youtube/v3/videos',
      parameters,
    );

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      pageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> collection = [];
      videosJson.forEach(
        (json) => collection.add(
          Video.fromIdsMap(json),
        ),
      );
      return collection;
    } else {
      Logger().e(json.decode(response.body)['error']['message']);
      return List<Video>.from([]).toList();
    }
  }
}
