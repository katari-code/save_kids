import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/components/parent_components/video_card.dart';
import 'package:save_kids/models/video.dart';

import 'package:save_kids/services/youtube_api_provider.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<Video> videoList = [];
  @override
  void initState() {
    YoutubeApiProvider _youtube = YoutubeApiProvider<Video>();
    _youtube
        .fetchBySearch(search: "Toys", mapper: Video(), type: 'video')
        .then((value) {
      setState(() {
        videoList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.15,
            child: Transform.scale(
              scale: 5,
              child: SvgPicture.asset("images/svgs/background.svg"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: videoList.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (index != null) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: VideoCard(
                      videoList[index].thumbnailUrl,
                      videoList[index].title,
                      videoList[index].description,
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }
}
