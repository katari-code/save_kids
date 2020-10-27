import 'package:flutter/material.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen/video_player_screen.dart';

class VideoGrid extends StatefulWidget {
  final Function removeVideoAfterReport;
  const VideoGrid(
      {Key key,
      @required this.addToWatchHistory,
      this.videoStream,
      this.removeVideoAfterReport})
      : super(key: key);

  final Function addToWatchHistory;

  final Stream videoStream;

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: StreamBuilder<List<Video>>(
          stream: widget.videoStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Video> videoList = [];
              videoList.addAll(snapshot.data);

              return SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  physics: ClampingScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: videoList.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () async {
                      widget.addToWatchHistory(videoList[index].id);
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
                      videoId: videoList[index].id,
                      removeVideoAfterReport: widget.removeVideoAfterReport,
                    ),
                  ),
                ),
              );
            }
            return ProgressBar();
          }),
    );
  }
}
