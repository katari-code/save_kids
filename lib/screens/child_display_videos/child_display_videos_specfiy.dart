import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/bloc/video_list__specify_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/timer.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';
import 'package:save_kids/util/style.dart';
import 'widget/childTimer.dart';

class ChildMainViedoListSpecify extends StatefulWidget {
  final String childId;
  ChildVideoListSpecifyBloc videoListBloc = ChildVideoListSpecifyBloc();

  ChildMainViedoListSpecify(this.childId);
  @override
  _ChildMainViedoListSpecifyState createState() =>
      _ChildMainViedoListSpecifyState();
}

class _ChildMainViedoListSpecifyState extends State<ChildMainViedoListSpecify>
    with WidgetsBindingObserver {
  int selectedIndex = 0;

  @override
  void initState() {
    widget.videoListBloc.childId.add(widget.childId);

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
    ChildVideoListSpecifyBloc().dispose();
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
        ChildVideoListSpecifyBloc().storeTimer(widget.childId);
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
                            ],
                          ),
                        ),
                        FutureBuilder<List<Video>>(
                          initialData: [],
                          future: widget.videoListBloc.fetchVideos(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Video> videoList = [];
                              videoList.addAll(snapshot.data);
                              return VideoGrid(
                                videoList: videoList,
                                addToWatchHistory: (String videoId) =>
                                    widget.videoListBloc.updateWatchHistory(
                                        videoId, widget.childId),
                              );
                            } else
                              return CircularProgressIndicator();
                          },
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
