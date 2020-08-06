import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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

  Future<List<T>> fetchBySearch(
      {Mapper mapper, String search, String type}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'type': type,
      'maxResults': '8',
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

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<T> collection = [];
      videosJson.forEach(
        (json) => collection.add(
          mapper.fromSearchMap(json),
        ),
      );
      return collection;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

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
      throw json.decode(response.body)['error']['message'];
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
      'youtube/v3/channels',
      parameters,
    );

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      // channel.videos = await fetchVideosFromPlaylist(
      //     playlistId: channel.uploadPlaylistId, pageToken: _nextPageToken);
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<String> fetchPlayListId({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      'youtube/v3/channels',
      parameters,
    );

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      return channel.uploadPlaylistId;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<Map> fetchVideosFromPlaylist(
      {String playlistId, String pageToken}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '2',
      'pageToken': pageToken,
      'safeSearch': 'strict',
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      '/playlistItems',
      parameters,
    );

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      pageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json),
        ),
      );
      return {'videos': videos, 'pageToken': pageToken};
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
