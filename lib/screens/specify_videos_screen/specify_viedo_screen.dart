import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_kids/bloc/specify_add_video_bloc.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/screens/child_display_videos/video_player_screen_copy/video_player_screen.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

class SpecifyVideoScreen extends StatefulWidget {
  String childID;
  SpecifyVideoScreen({this.childID});
  @override
  _SpecifyVideoScreenState createState() => _SpecifyVideoScreenState();
}

class _SpecifyVideoScreenState extends State<SpecifyVideoScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SpecifyAddVideoBloc specifyAddVideoBloc =
        BlocProvider.getBloc<SpecifyAddVideoBloc>();
    specifyAddVideoBloc.childId.add(widget.childID);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        specifyAddVideoBloc.getVideoBySearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "images/background.png",
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            Consumer<SpecifyAddVideoBloc>(
                builder: (conext, specifyAddVideoBloc) {
              // specifyAddVideoBloc.getVideosFromDB(widget.childID);

              return Center(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.90,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Videos',
                                style: kBubblegum_sans40.copyWith(
                                    color: kBlueDarkColor),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 32,
                                  color: kRedColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          buildSearchButton(specifyAddVideoBloc),
                          SizedBox(
                            height: 18,
                          ),
                          CarouselSlider.builder(
                            itemCount: specifyAddVideoBloc.languages.length,
                            itemBuilder: (context, index) => Container(
                              child: Text(
                                specifyAddVideoBloc.languages[index].lnName ??
                                    "  ",
                                style: kBubblegum_sans24.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            options: CarouselOptions(
                              onPageChanged: (index, _) {
                                print(specifyAddVideoBloc.languages.length);
                                specifyAddVideoBloc.changeLanguage(
                                    specifyAddVideoBloc.languages[index]);
                              },
                              height: 50,
                              initialPage: 0,
                              viewportFraction: 0.45,
                              enableInfiniteScroll: true,
                              reverse: false,
                              enlargeCenterPage: true,
                            ),
                          ),
                          specifyAddVideoBloc.searchResult.value == null
                              ? StreamBuilder<List<Video>>(
                                  stream:
                                      specifyAddVideoBloc.videosFromDB.stream,
                                  builder: (context, snapshot) {
                                    List<Video> videos = snapshot.data ?? [];
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.80 /
                                              1.75,
                                      child: ListView.builder(
                                        // shrinkWrap: true,
                                        itemCount: videos.length,

                                        itemBuilder: (context, index) =>
                                            CustomAnimation(
                                          duration: Duration(milliseconds: 600),
                                          delay: Duration(
                                            milliseconds: (500 * 2).round(),
                                          ),
                                          curve: Curves.elasticOut,
                                          tween: Tween<double>(
                                            begin: 0,
                                            end: 1,
                                          ),
                                          builder: (context, child, value) =>
                                              Transform.scale(
                                            scale: value,
                                            child: buildVideoCard(
                                                videos,
                                                index,
                                                specifyAddVideoBloc
                                                    .changeChosenVideosFromDB),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : StreamBuilder<List<Video>>(
                                  stream: specifyAddVideoBloc.videos,
                                  builder: (context, snapshot) {
                                    List<Video> videos = snapshot.data ?? [];
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.80 /
                                              1.75,
                                      child: ListView.builder(
                                        // shrinkWrap: true,
                                        itemCount: videos.length,
                                        controller: _scrollController,
                                        itemBuilder: (context, index) =>
                                            CustomAnimation(
                                          duration: Duration(milliseconds: 600),
                                          delay: Duration(
                                            milliseconds: (500 * 2).round(),
                                          ),
                                          curve: Curves.elasticOut,
                                          tween: Tween<double>(
                                            begin: 0,
                                            end: 1,
                                          ),
                                          builder: (context, child, value) =>
                                              Transform.scale(
                                            scale: value,
                                            child: buildVideoCard(
                                                videos,
                                                index,
                                                specifyAddVideoBloc
                                                    .addChosenVideo),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          SizedBox(
                            height: 18,
                          ),
                          buildButton(context, specifyAddVideoBloc)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  StreamBuilder<Object> buildSearchButton(
      SpecifyAddVideoBloc specifyAddVideoBloc) {
    return StreamBuilder<Object>(
        stream: specifyAddVideoBloc.searchResult,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 45,
                // padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    onChanged: specifyAddVideoBloc.changeSearchResult,
                    // onSubmitted: ,
                    decoration: InputDecoration(
                      // errorText: snapshot.error,

                      hintText: "Try Science For Kids ",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 2.00),
                      color: Color(0xff000000).withOpacity(0.10),
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.00),
                ),
              ),
              Container(
                width: 50,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 2.00),
                      color: Color(0xff000000).withOpacity(0.10),
                      blurRadius: 6,
                    )
                  ],
                  color: kYellowColor,
                ),
                child: FlatButton(
                  onPressed: () => specifyAddVideoBloc.getVideoBySearch(),
                  child: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  Widget buildVideoCard(
      List<Video> videos, int index, Function changeChosenVideo) {
    return GestureDetector(
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen2(
            viedoId: videos[index].id,
          ),
        ),
      ),
      onTap: () {
        changeChosenVideo(videos[index].id);
        setState(() {});
      },
      child: Container(
        // height: 105.00,
        width: 336.00,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
        ),
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 105.00,
                width: 10.00,
                decoration: BoxDecoration(
                  color: videos[index].chosen
                      ? kRedColor
                      : kChannelUnSelectedColor,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                Container(
                  height: 105.00,
                  child: Image.network(
                    videos[index].thumbnailUrl,
                    fit: BoxFit.cover,
                    width: 336 / 2.5,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Text(
                          videos[index].title,
                          style: kCapriola20.copyWith(
                              fontSize: 18, color: kBlueDarkColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          videos[index].description,
                          style: kCapriola20.copyWith(
                              fontSize: 14, color: kBlueDarkColor),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildButton(
      BuildContext context, SpecifyAddVideoBloc specifyAddVideoBloc) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: kBlueDarkColor,
        onPressed: () {
          specifyAddVideoBloc.updateSpecifyVideos(widget.childID);
          specifyAddVideoBloc.changeLanguage(specifyAddVideoBloc.languages[0]);
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.00),
        ),
        child: Text(
          'Done',
          style: kBubblegum_sans24.copyWith(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
