import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/bloc/child_viedo_list_bloc_watch_schedule.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/channel.dart';
import 'package:save_kids/models/schedule.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';
import 'package:save_kids/screens/child_display_videos/widget/childTimer_watch_schedule.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

class ChildMainViedoListWatchSchedule extends StatefulWidget {
  final Schedule schedule;
  ChildVideoListWSBloc childVideoListWSBloc = ChildVideoListWSBloc();
  ChildMainViedoListWatchSchedule({this.schedule});

  @override
  _ChildMainViedoListWatchScheduleState createState() =>
      _ChildMainViedoListWatchScheduleState();
}

class _ChildMainViedoListWatchScheduleState
    extends State<ChildMainViedoListWatchSchedule> {
  int selectedIndexChannel = -1;
  int selectedIndexCateg = -1;
  int selectedIndexSpesfy = 0;
  bool isChannel = false;
  bool isSpesfy = false;
  final List<Category> categoriesO = [];
  refresh() {
    setState(() {
//all the reload processes
    });
  }

  @override
  void initState() {
    super.initState();
    widget.childVideoListWSBloc.childId.add(widget.schedule.childId);
    widget.childVideoListWSBloc.scheduleId.add(widget.schedule.id);
    Timer(Duration(seconds: 3), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Category> categoriesO = [];

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
          Stack(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(25.0),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: categories[selectedIndex].v2 != null
              //         ? SvgPicture.network(
              //             categories[selectedIndex].v2,
              //             width: MediaQuery.of(context).size.width * 0.20,
              //             fit: BoxFit.cover,
              //           )
              //         : Text(" "),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(25),
              //   child: Align(
              //     alignment: Alignment.bottomLeft,
              //     child: categories[selectedIndex].v1 != null
              //         ? SvgPicture.network(
              //             categories[selectedIndex].v1,
              //             width: MediaQuery.of(context).size.width * 0.20,
              //             fit: BoxFit.cover,
              //           )
              //         : Text(" "),
              //   ),
              // ),
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
                        StreamBuilder<Schedule>(
                            stream: widget.childVideoListWSBloc.schedule.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Schedule schedule = snapshot.data;
                                for (var i = 0;
                                    i < schedule.categories.length;
                                    i++) {
                                  categoriesO.add(
                                      categoriesList[schedule.categories[i]]);
                                }

                                return StreamBuilder<List<Channel>>(
                                  stream: widget
                                      .childVideoListWSBloc.channels.stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Channel> channels = [];
                                      channels.addAll(snapshot.data);

                                      List<GestureDetector> childerns = [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndexChannel = -1;
                                              selectedIndexCateg = -1;
                                              isSpesfy = true;
                                              isChannel = false;
                                            });
                                          },
                                          child: CustomAnimation(
                                            duration:
                                                Duration(milliseconds: 800),
                                            delay: Duration(
                                              milliseconds: (800 * 2).round(),
                                            ),
                                            curve: Curves.elasticOut,
                                            tween: Tween<double>(
                                              begin: 0,
                                              end: 1,
                                            ),
                                            builder: (context, child, value) =>
                                                Container(
                                              margin: EdgeInsets.all(8),
                                              child: Transform.scale(
                                                scale: value,
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: isSpesfy ==
                                                                false
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                19
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                17,
                                                        backgroundImage:
                                                            AssetImage(
                                                          "images/viedos.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        child: Text(
                                                          "Recommended videos",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              kBubblegum_sans16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ...List<GestureDetector>.generate(
                                          categoriesO.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              widget.childVideoListWSBloc
                                                  .changeCategory(
                                                      categoriesO[index]);
                                              setState(() {
                                                selectedIndexCateg = index;
                                                selectedIndexChannel = -1;
                                                selectedIndexSpesfy = -1;
                                                isChannel = false;
                                                isSpesfy = false;
                                              });
                                            },
                                            child: CustomAnimation(
                                              duration:
                                                  Duration(milliseconds: 800),
                                              delay: Duration(
                                                milliseconds: (800 * 2).round(),
                                              ),
                                              curve: Curves.elasticOut,
                                              tween: Tween<double>(
                                                begin: 0,
                                                end: 1,
                                              ),
                                              builder:
                                                  (context, child, value) =>
                                                      Container(
                                                margin: EdgeInsets.all(8),
                                                child: Transform.scale(
                                                  scale: value,
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: selectedIndexCateg !=
                                                                index
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                17
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                14,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        child: Image.network(
                                                          categoriesO[index]
                                                              .imgURl,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ...List<GestureDetector>.generate(
                                          channels.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndexChannel = index;
                                                selectedIndexCateg = -1;
                                                isChannel = true;
                                              });
                                            },
                                            child: CustomAnimation(
                                              duration:
                                                  Duration(milliseconds: 800),
                                              delay: Duration(
                                                milliseconds: (800 * 2).round(),
                                              ),
                                              curve: Curves.elasticOut,
                                              tween: Tween<double>(
                                                begin: 0,
                                                end: 1,
                                              ),
                                              builder:
                                                  (context, child, value) =>
                                                      Container(
                                                margin: EdgeInsets.all(8),
                                                child: Transform.scale(
                                                  scale: value,
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: selectedIndexChannel !=
                                                                  index
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  19
                                                              : MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  17,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            channels[index]
                                                                .profilePictureUrl,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          child: Text(
                                                            channels[index]
                                                                .title,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                kBubblegum_sans16,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ];
                                      return Column(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 140,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: childerns,
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

                                          isChannel == false
                                              ? FutureBuilder<List<Video>>(
                                                  future: isSpesfy != false
                                                      ? widget
                                                          .childVideoListWSBloc
                                                          .videosFromDB
                                                          .first
                                                      : widget
                                                          .childVideoListWSBloc
                                                          .fetchVideos(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<Video> videoList =
                                                          [];
                                                      videoList.addAll(
                                                          snapshot.data);
                                                      return VideoGrid(
                                                        videoList: videoList,
                                                        addToWatchHistory: (String
                                                                videoId) =>
                                                            widget
                                                                .childVideoListWSBloc
                                                                .updateWatchHistory(
                                                                    videoId,
                                                                    widget
                                                                        .schedule
                                                                        .childId),
                                                      );
                                                    } else
                                                      return CircularProgressIndicator();
                                                  },
                                                )
                                              : Text(''),
                                        ],
                                      );
                                    } else {
                                      return ProgressBar();
                                    }
                                  },
                                );
                              }
                              return ProgressBar();
                            }),
                        isChannel == true
                            ? StreamBuilder<List<Channel>>(
                                stream:
                                    widget.childVideoListWSBloc.streamChannels,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data.length != 0) {
                                    List<Channel> channelList = [];
                                    channelList.addAll(snapshot.data);
                                    print(snapshot.data.length);
                                    return VideoGrid(
                                      videoList:
                                          channelList[selectedIndexChannel]
                                              .videos,
                                      addToWatchHistory: (String videoId) =>
                                          widget.childVideoListWSBloc
                                              .updateWatchHistory(videoId,
                                                  widget.schedule.childId),
                                    );
                                  } else
                                    return CircularProgressIndicator();
                                },
                              )
                            : Text(" "),
                      ],
                    ),
                  ),
                ],
              ),

              StreamBuilder<Schedule>(
                stream: widget.childVideoListWSBloc.schedule,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.dateEnd != null) {
                    return ChildTimerWatchSchedule(
                      totalSec: snapshot.data.dateEnd
                          .difference(snapshot.data.dateStart)
                          .inSeconds
                          .toDouble(),
                      remainSec: snapshot.data.dateEnd
                          .difference(DateTime.now())
                          .inSeconds,
                    );
                  }
                  return ProgressBar();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  const VideoGrid(
      {Key key, @required this.videoList, @required this.addToWatchHistory})
      : super(key: key);

  final List<Video> videoList;
  final Function addToWatchHistory;
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
            onTap: () async {
              addToWatchHistory(videoList[index].id);
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
