import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final viedoId;
  VideoPlayerScreen({this.viedoId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: widget.viedoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.11),
                    blurRadius: 100,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "images/BK.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SvgPicture.asset("images/svgs/Back_video.svg"),
                  YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      width: MediaQuery.of(context).size.width,
                      aspectRatio: 16 / 9,
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        print('Player is ready.');
                      },
                    ),
                    builder: (context, player) => Column(
                      children: [
                        // some widgets
                        player,
                        //some other widgets
                      ],
                    ),
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
