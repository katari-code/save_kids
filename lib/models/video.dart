import 'dart:convert';

import 'package:save_kids/models/interfaces/i_mapper.dart';

class Video implements Mapper {
  String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String description;
  bool chosen;
  Video(
      {this.id,
      this.title,
      this.chosen,
      this.thumbnailUrl,
      this.channelTitle,
      this.description});

  Video.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          thumbnailUrl: json['thumbnailUrl'],
          channelTitle: json['channelTitle'],
          description: json['description'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'channelTitle': channelTitle,
        'description': description
      };

  static String encodeVideos(List<Video> videos) => json.encode(
        videos
            .map<Map<String, dynamic>>(
              (video) => video.toJson(),
            )
            .toList(),
      );

  static List<Video> decodeVideos(String videos) =>
      (json.decode(videos) as List<dynamic>)
          .map<Video>((video) => Video.fromJson(video))
          .toList();

  factory Video.fromMap(
    Map<String, dynamic> map,
  ) {
    return Video(
      id: map['id']['videoId'],
      description: map['snippet']['description'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['medium']['url'],
      channelTitle: map['snippet']['channelTitle'],
      chosen: false,
    );
  }
  factory Video.fromIdsMap(
    Map<String, dynamic> map,
  ) {
    return Video(
      id: map['id'],
      description: map['snippet']['description'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['high']['url'],
      channelTitle: map['snippet']['channelTitle'],
      chosen: false,
    );
  }

  @override
  fromSearchMap(Map<String, dynamic> map) {
    return Video.fromMap(map);
  }

  fromIdsMap(Map<String, dynamic> map) {
    return Video.fromIdsMap(map);
  }
}
