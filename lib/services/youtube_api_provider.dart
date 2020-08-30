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

  Future<List<T>> fethList({
    List<String> collection,
    String type,
    Mapper mapper,
  }) async {
    String ids = '';
    collection.forEach((video) {
      ids += '$video,';
    });
    Map<String, String> parameters = {
      'part': 'snippet',
      'type': type,
      'id': ids,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      'youtube/v3/${type}s',
      parameters,
    );

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      pageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<T> collections = [];
      videosJson.forEach(
        (json) => collections.add(
          mapper.fromIdsMap(json),
        ),
      );
      return collections;
    } else {
      Logger().e(json.decode(response.body)['error']['message']);
      return List<T>.from([]).toList();
    }
  }

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // final map = await fetchVideosFromPlaylist(
      //   playlistId: channel.uploadPlaylistId,
      // );
      // channel.videos = map['data'];
      channel.pageToken = '';
      return channel;
    } else {
      Logger().e(json.decode(response.body)['error']['message']);
      return null;
    }
  }

  Future<Map> fetchVideosFromPlaylist(
      {String playlistId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': pageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      pageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];
      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach((json) {
        videos.add(
          Video.fromMapSearch(json['snippet']),
        );
      });
      return {'data': videos, 'pageToken': pageToken};
    } else {
      Logger().e(json.decode(response.body)['error']['message']);
      return {'data': List<Video>.from([]).toList(), 'pageToken': ''};
    }
  }
}
