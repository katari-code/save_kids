import 'package:save_kids/models/i_mapper.dart';

class Video implements Mapper {
  String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String description;
  Video(
      {this.id,
      this.title,
      this.thumbnailUrl,
      this.channelTitle,
      this.description});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id']['videoId'],
      description: map['snippet']['description'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['medium']['url'],
      channelTitle: map['snippet']['channelTitle'],
    );
  }

  @override
  fromSearchMap(Map<String, dynamic> map) {
    return Video.fromMap(map);
  }
}
