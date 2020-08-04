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

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      baseUrl,
      '/channels',
      parameters,
    );

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
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

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
