import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/child_video_list_bloc.dart';
import 'package:flutter/services.dart';
import 'package:save_kids/bloc/test/video_list_bloc_test.dart';
import 'package:save_kids/bloc/video_reporting_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/models/category.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/screens/child_display_videos/widget/video_grid.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';
import 'widget/childTimer.dart';

class ChildMainViedoList extends StatefulWidget {
  final String childId;
  final ChildVideoListBloc videoListBloc = ChildVideoListBloc();

  ChildMainViedoList(this.childId);
  @override
  _ChildMainViedoListState createState() => _ChildMainViedoListState();
}

class _ChildMainViedoListState extends State<ChildMainViedoList>
    with WidgetsBindingObserver {
  ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;

  @override
  void initState() {
    widget.videoListBloc.childId.add(widget.childId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.videoListBloc.fetchVideos();
      }
    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    widget.videoListBloc.storeTimer(widget.childId);
    ChildVideoListBloc().dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        ChildVideoListBloc().storeTimer(widget.childId);
        break;
      case AppLifecycleState.resumed:
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _scrollController,
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
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List<GestureDetector>.generate(
                            categories.length,
                            (index) => GestureDetector(
                              onTap: () {
                                widget.videoListBloc
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
                                          ? MediaQuery.of(context).size.width /
                                              12
                                          : MediaQuery.of(context).size.width /
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
                        VideoGrid(
                          videoStream: widget.videoListBloc.videoList.stream,
                          addToWatchHistory: (String videoId) => widget
                              .videoListBloc
                              .updateWatchHistory(videoId, widget.childId),
                          removeVideoAfterReport:
                              widget.videoListBloc.removeVideoAfterVideoReport,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StreamBuilder<Timer>(
                stream: widget.videoListBloc.timer,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.remainSec != null) {
                    return ChildTimer(
                        snapshot.data,
                        widget.videoListBloc.updateTimer,
                        widget.videoListBloc,
                        widget.childId);
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
