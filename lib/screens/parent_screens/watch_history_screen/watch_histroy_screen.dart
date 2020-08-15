import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/watch_history_bloc.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/video_card.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/util/style.dart';

class WatchHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 80,
                        // width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: kYellowColor,
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 30,
                                color: Colors.white,
                              ),
                              Text(
                                "Watch History",
                                style: kBubblegum_sans40.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
           
                  Consumer<WatchHistoryBloc>(
                    builder: (context, watchHistoryBloc) {
                      return StreamBuilder<List<Child>>(
                          stream: watchHistoryBloc.children,
                          builder: (context, snapshot) {
                            if (snapshot.data != null &&
                                snapshot.data.length > 0) {
                              return Column(
                                children: [
                                  ...List<Widget>.generate(
                                    snapshot.data.length,
                                    (index) => Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            children: [
                                              Stack(
                                                children: [
                                                  Center(
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          kYellowColor,
                                                      radius: 40,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 35,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          snapshot.data[index]
                                                              .imagePath,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                snapshot.data[index].name,
                                                style:
                                                    kBubblegum_sans32.copyWith(
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: FutureBuilder<List<Video>>(
                                              future: watchHistoryBloc
                                                  .getVideos(snapshot
                                                      .data[index]
                                                      .watchHistory),
                                              builder: (context, videos) {
                                                if (videos.hasData &&
                                                    videos.data.length > 0) {
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    itemCount:
                                                        videos.data.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            VideoCardEnhanced(
                                                      videoTitle: videos
                                                          .data[index].title,
                                                      image: videos.data[index]
                                                          .thumbnailUrl,
                                                    ),
                                                  );
                                                }
                                                return Text('Nothing to show');
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return ProgressBar();
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
