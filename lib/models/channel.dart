import 'package:save_kids/models/mapper.dart';
import 'package:save_kids/models/video.dart';

class Channel implements Mapper {
  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistId;
  final String description;
  List<Video> videos;

  Channel(
      {this.id,
      this.title,
      this.profilePictureUrl,
      this.subscriberCount,
      this.videoCount,
      this.uploadPlaylistId,
      this.videos,
      this.description});

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }

  Channel.fromSearchMap(Map<String, dynamic> map)
      : this(
          id: map['snippet']['channelId'],
          title: map['snippet']['title'],
          profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
          description: map['snippet']['description'],
        );

  @override
  fromSearchMap(Map<String, dynamic> map) {
    return Channel.fromSearchMap(map);
  }
}
