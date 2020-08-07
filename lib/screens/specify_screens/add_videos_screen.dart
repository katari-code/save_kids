import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/add_video_bloc.dart';
import 'package:save_kids/models/video.dart';
import 'package:save_kids/util/style.dart';
import 'package:simple_animations/simple_animations.dart';

class AddVideoScreen extends StatefulWidget {
  @override
  _AddVideoScreenState createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final languages = ['English', 'French', 'Spanish'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.10,
              child: SvgPicture.asset(
                "images/svgs/Asset1.svg",
                color: Colors.black,
                fit: BoxFit.cover,
              ),
            ),
            Consumer<AddVideoBloc>(
              builder: (conext, addVideoBloc) => Center(
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
                              Icon(
                                Icons.cancel,
                                size: 32,
                                color: kRedColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          buildSearchButton(addVideoBloc),
                          SizedBox(
                            height: 18,
                          ),
                          CarouselSlider.builder(
                            itemCount: languages.length,
                            itemBuilder: (context, index) => Container(
                              child: Text(
                                languages[index],
                                style: kBubblegum_sans24.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            options: CarouselOptions(
                              height: 50,
                              initialPage: 0,
                              viewportFraction: 0.30,
                              enableInfiniteScroll: true,
                              reverse: false,
                              enlargeCenterPage: true,

                              // onPageChanged: (index, reason) => ,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          StreamBuilder<List<Video>>(
                            stream: addVideoBloc.videos,
                            builder: (context, snapshot) {
                              List<Video> videos = snapshot.data ?? [];
                              return Container(
                                height: MediaQuery.of(context).size.height *
                                    0.80 /
                                    1.75,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List<CustomAnimation>.generate(
                                      videos.length,
                                      (index) => CustomAnimation(
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
                                              videos, index, addVideoBloc),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          buildButton(context, addVideoBloc)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder<Object> buildSearchButton(AddVideoBloc addVideoBloc) {
    return StreamBuilder<Object>(
        stream: addVideoBloc.searchResult,
        builder: (context, snapshot) {
          return Container(
            // padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: addVideoBloc.changeSearchResult,
              // onSubmitted: ,
              decoration: InputDecoration(
                // errorText: snapshot.error,
                prefixIcon: GestureDetector(
                  onTap: () => addVideoBloc.getVideoBySearch(),
                  child: Icon(Icons.search),
                ),
                hintText: "Try Science For Kids ",
                border: InputBorder.none,
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
          );
        });
  }

  Widget buildVideoCard(
      List<Video> videos, int index, AddVideoBloc addVideoBloc) {
    return GestureDetector(
      onTap: () {
        addVideoBloc.addChosenVideo(videos[index].id);
      },
      child: Container(
        height: 105.00,
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
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(100),
          ),
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
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(100),
                  ),
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

  Container buildButton(BuildContext context, AddVideoBloc addVideoBloc) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: RaisedButton(
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 18),
        color: kBlueDarkColor,
        onPressed: () {
          Navigator.pop(context, addVideoBloc.returnChosenVideos());
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
