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
