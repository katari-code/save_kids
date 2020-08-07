import 'package:save_kids/models/interfaces/i_mapper.dart';
import 'package:save_kids/models/video.dart';

class Channel implements Mapper {
  final String id;
  final String title;
  final String profilePictureUrl;
  final String subscriberCount;
  final String videoCount;
  final String uploadPlaylistId;
  final String description;
  bool chosen;
  List<Video> videos;

  Channel(
      {this.id,
      this.title,
      this.profilePictureUrl,
      this.subscriberCount,
      this.videoCount,
      this.uploadPlaylistId,
      this.videos,
      this.chosen,
      this.description});

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
        id: map['id'],
        title: map['snippet']['title'],
        profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
        subscriberCount: map['statistics']['subscriberCount'],
        videoCount: map['statistics']['videoCount'],
        uploadPlaylistId: map['contentDetails']['relatedPlaylists']['uploads'],
        chosen: false);
  }

  Channel.fromSearchMap(Map<String, dynamic> map)
      : this(
            id: map['snippet']['channelId'],
            title: map['snippet']['title'],
            profilePictureUrl: map['snippet']['thumbnails']['default']['url'],
            description: map['snippet']['description'],
            chosen: false);

  @override
  fromSearchMap(Map<String, dynamic> map) {
    return Channel.fromSearchMap(map);
  }
}
// import 'package:flutter/cupertino.dart';

// class Channel {
//   String channelId;
//   String channelName;
//   String channelAvatar;
//   String channelDesc;
//   bool isChose;

//   Channel({
//     this.channelId,
//     this.channelName,
//     this.channelDesc,
//     this.channelAvatar,
//     this.isChose,
//   });
// }

// class ChannelData with ChangeNotifier {
//   List<Channel> channels = [
//     Channel(
//       channelId: "001",
//       channelName: "Kids Channel",
//       channelAvatar:
//           "https://yt3.ggpht.com/a/AATXAJyttsvxVYq7Lu5KGRCK9J1QHA6fWDDhwXnIEPe7Nw=s176-c-k-c0x00ffffff-no-rj",
//       channelDesc:
//           "Kids Channel is an online educational platform, specializing in graphic videos, nursery rhymes and songs for children. ",
//       isChose: true,
//     ),
//     Channel(
//       channelId: "002",
//       channelName: "Loco Nuts",
//       channelAvatar:
//           "https://yt3.ggpht.com/a/AATXAJzPJy22RVQQJNASRQyzBbcSIMbmwuC7k7pvY7wg=s176-c-k-c0x00ffffff-no-rj",
//       channelDesc:
//           "he series revolves around the fun adventures of 6 animal friends",
//       isChose: false,
//     ),
//   ];
// }
