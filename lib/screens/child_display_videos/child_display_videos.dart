import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as Bolc;
import 'package:save_kids/bloc/child_video_list_bloc.dart';
import 'package:flutter/services.dart';

import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';
import 'widget/childTimer.dart';

class ChildMainViedoList extends StatefulWidget {
  final String childId;
  ChildMainViedoList(this.childId);
  @override
  _ChildMainViedoListState createState() => _ChildMainViedoListState();
}

class _ChildMainViedoListState extends State<ChildMainViedoList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.childId);

    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Container(
            width: 10,
          ),
          Transform.scale(
            scale: 1.2,
            child: SvgPicture.asset(
              "images/BKgChildViedoList.svg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.5),
          ),
          Bolc.Consumer<ChildVideoListBloc>(builder: (context, videoListBloc) {
            videoListBloc.childId = widget.childId;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: categories[selectedIndex].v2 != null
                        ? SvgPicture.network(
                            categories[selectedIndex].v2,
                            width: MediaQuery.of(context).size.width * 0.20,
                            fit: BoxFit.cover,
                          )
                        : Text(" "),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: categories[selectedIndex].v1 != null
                        ? SvgPicture.network(
                            categories[selectedIndex].v1,
                            width: MediaQuery.of(context).size.width * 0.20,
                            fit: BoxFit.cover,
                          )
                        : Text(" "),
                  ),
                ),
                ListView(
                  children: [
                    SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: SvgPicture.asset(
                                    'images/svgs/Back_video.svg',
                                    height: 70,
                                  ),
                                ),
                                Column(
                                  children: [
                                    // CircleAvatar(
                                    //   radius: 33,
                                    //   backgroundColor: kYellowColor,
                                    //   child: CircleAvatar(
                                    //     radius: 30,
                                    //     backgroundColor: Colors.white,
                                    //     backgroundImage: NetworkImage(
                                    //       Provider.of<KidsData>(context)
                                    //           .kids[0]
                                    //           .imagePath,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List<GestureDetector>.generate(
                              categories.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  videoListBloc
                                      .changeCategory(categories[index]);
                                  setState(() {
                                    selectedIndex = categoriesList[index].index;
                                  });
                                },
                                child: CustomAnimation(
                                  duration: Duration(milliseconds: 800),
                                  delay: Duration(
                                    milliseconds: (800 * 2).round(),
                                  ),
                                  curve: Curves.elasticOut,
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ),
                                  builder: (context, child, value) => Container(
                                    child: Transform.scale(
                                      scale: value,
                                      child: Image.network(
                                        categoriesList[index].imgURl,
                                        width: selectedIndex !=
                                                categoriesList[index].index
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                12
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                        height: 110,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //             // Wrap(
                          //             //   children: List<VideoCardEnhanced>.generate(
                          //             //     categoriesList.length,
                          //             //     (index) => VideoCardEnhanced(),
                          //             //   ),
                          //             // ),
                          //             // SizedBox(
                          //             //   height: 180,
                          //             //   child: ListView.builder(
                          //             //     padding: const EdgeInsets.only(left: 50.0),
                          //             //     scrollDirection: Axis.horizontal,
                          //             //     itemCount: 50,
                          //             //     itemBuilder: (context, index) => VideoCardEnhanced(),
                          //             //   ),
                          //             // ),
                          FutureBuilder<List<Video>>(
                            future: videoListBloc.fetchVideos(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Video> videoList = [];
                                videoList.addAll(snapshot.data);
                                Logger().i(videoList.length);
                                return VideoGrid(videoList: videoList);
                              } else
                                return CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ChildTimer(videoListBloc),
              ],
            );
          })
        ],
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  const VideoGrid({
    Key key,
    @required this.videoList,
  }) : super(key: key);

  final List<Video> videoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SingleChildScrollView(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
          ),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: videoList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    viedoId: videoList[index].id,
                  ),
                ),
              );
            },
            child: VideoCardEnhanced(
              videoTitle: videoList[index].title,
              image: videoList[index].thumbnailUrl,
            ),
          ),
        ),
      ),
    );
  }
}
