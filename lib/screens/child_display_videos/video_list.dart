import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/components/parent_components/video_card.dart';
import 'package:save_kids/models/video.dart';

// import 'package:save_kids/services/youtube_api_provider.dart';

class VideoList extends StatefulWidget {
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<VideoListBloc>(
          builder: (conext, videoListBloc) => Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.15,
                child: Transform.scale(
                  scale: 5,
                  child: SvgPicture.asset("images/svgs/background.svg"),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10,
                        children: List.generate(
                          categories.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                videoListBloc.changeCategory(categories[index]);
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                color: Colors.red,
                                padding: EdgeInsets.all(8),
                                child: Text(categories[index].categoryName),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      FutureBuilder<List<Video>>(
                          future: videoListBloc.fetchVideos(),
                          builder: (context, snapshot) {
                            List<Video> videoList = [];
                            videoList.addAll(snapshot.data);

                            Logger().i(videoList.length);
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children:
                                    List.generate(videoList.length, (index) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    margin:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    child: VideoCard(
                                        videoList[index].thumbnailUrl,
                                        videoList[index].title,
                                        videoList[index].description),
                                  );
                                }).toList(),
                              ),
                            );
                            // return ListView.builder(
                            //   itemCount: videoList.length,
                            //   scrollDirection: Axis.vertical,
                            //   padding: EdgeInsets.all(8),
                            //   itemBuilder: (context, index) {
                            //     if (index != null) {
                            //       return Container(
                            //         height: MediaQuery.of(context).size.height * 0.45,
                            //         margin: EdgeInsets.only(bottom: 10, top: 10),
                            //         child: VideoCard(
                            //             videoList[index].thumbnailUrl,
                            //             videoList[index].title,
                            //             videoList[index].description),
                            //       );
                            //     }
                            //     return CircularProgressIndicator();
                            //   },
                            // );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
