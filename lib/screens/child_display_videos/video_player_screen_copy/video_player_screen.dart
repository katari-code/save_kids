import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen2 extends StatefulWidget {
  final viedoId;
  VideoPlayerScreen2({this.viedoId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen2> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.viedoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Stack(
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              width: MediaQuery.of(context).size.width,
              aspectRatio: 16 / 9,
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {},
            ),
            builder: (context, player) => Column(
              children: [
                player,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
